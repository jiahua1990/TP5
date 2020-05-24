<?php

namespace app\store\model\dealer;

use app\common\model\dealer\Referee as RefereeModel;
use app\store\model\dealer\User as DealerUserModel;
use app\store\model\dealer\Order as DealerOrderModel;

/**
 * 分销商推荐关系模型
 * Class Referee
 * @package app\store\model\dealer
 */
class Referee extends RefereeModel
{
	/**
     * 更换上级分销商
     * @param $data
     * @return \think\Paginator
     * @throws \think\exception\DbException
     */
    public function change_referee($data)
    {	
        if (!isset($data['user_id']) || empty($data['user_id'])) {
            $this->error = '请填写分销商用户ID';
            return false;
        }
    	// 判断更换用户是否是分销商
        if (!DealerUserModel::detail($data['user_id'])) {
            $this->error = "更换的用户【ID:{$data['user_id']}】不是分销商";
            return false;
        }

        // 开启事务
        $this->startTrans();
        try {
        	// 修改关联的分销商订单
        	$this->change_dealer_order($data);
        	// 更换上级分销商
        	$this->save(['id'=>$data['id'],'dealer_id'=>$data['user_id']]);

            $this->commit();
            return true;
        } catch (\Exception $e) {
            $this->error = $e->getMessage();
            $this->rollback();
            return false;
        }
    }

    /**
     * 修改关联的分销商订单
     * @param $images
     * @return int
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    private function change_dealer_order($data)
    {	
    	// 所有要改变用户的分销订单
        $model = new DealerOrderModel;
        if($this->level == 1) $model->where('first_user_id', '=', $this->dealer_id);
   		elseif($this->level == 2) $model->where('second_user_id', '=', $this->dealer_id);
   		elseif($this->level == 3) $model->where('third_user_id', '=', $this->dealer_id);
        $order = $model->where('user_id','=',$this->user_id)
    	  			   ->where('is_invalid', '=', 0)
        	  		   ->where('is_settled', '=', 0)
        	  		   ->field('id')
        	  		   ->select()->toArray();
       	foreach ($order as $key => &$val) {
       		if($this->level == 1) $val['first_user_id'] = $data['user_id'];
       		elseif($this->level == 2) $val['second_user_id'] = $data['user_id'];
       		elseif($this->level == 3) $val['third_user_id'] = $data['user_id'];
       	}
		if($order) $model->saveAll($order);
    }
}