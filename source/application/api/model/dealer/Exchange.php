<?php

namespace app\api\model\dealer;

use app\common\exception\BaseException;
use app\common\model\dealer\Exchange as ExchangeModel;
use app\api\model\Setting as SettingModel;
use app\store\model\user\BalanceLog as BalanceLogModel;
use app\store\model\user\PointsLog as PointsLogModel;

/**
 * 分销商积分兑换余额模型
 * Class Exchange
 * @package app\api\model\dealer
 */
class Exchange extends ExchangeModel
{
    /**
     * 隐藏字段
     * @var array
     */
    protected $updateTime = false;

    /**
     * 提交申请
     * @param User $dealer
     * @param $user
     * @param $data
     * @return false|int
     * @throws BaseException
     */
    public function submit($dealer, $user, $data)
    {
        // 数据验证
        $this->validation($dealer, $user, $data);
        $data['consume_points'] = $this->getConsumePoints($data);
        $wxapp_id = self::$wxapp_id;

        return $this->transaction( function() use ($user, $data , $wxapp_id) {
            // 减少用户积分
            $user->setDec('points', $data['consume_points']);
            // 新增积分变动记录
            PointsLogModel::add([
                'user_id' => $user['user_id'],
                'value' => -$data['consume_points'],
                'describe' => "[分销商]积分兑换余额",
                'wxapp_id' => $wxapp_id,
            ]);

            // 增加用户余额
            $user->setInc('balance', $data['balance']);
            // 新增余额变动记录
            BalanceLogModel::add(50, [
                'user_id' => $user['user_id'],
                'money' => $data['balance'],
                'wxapp_id' => $wxapp_id,
            ],["分销商"]);

            // 新增兑换记录
            return $this->save([
                'exchange_balance' => $data['balance'],
                'consume_points' => $data['consume_points'],
                'user_id' => $user['user_id'],
                'wxapp_id' => $wxapp_id,
            ]);
        });
    }

    /**
     * 数据验证
     * @param $dealer
     * @param $user
     * @param $data
     * @throws BaseException
     */
    private function validation($dealer, $user, $data)
    {   
        // 积分兑换设置
        $setting = SettingModel::getItem("points")['dealer'];
        // 是否开启
        if(!$setting['is_open']) {
            throw new BaseException(['msg' => '积分兑换余额功能已关闭']);
        }
        // 用户是否是分销商
        if(!(!!$dealer && !$dealer['is_delete'])) {
            throw new BaseException(['msg' => '不是分销商，不可提现']);
        }
        // 验证输入的兑换余额
        if ($data['balance'] < 0.01) {
            throw new BaseException(['msg' => '输入兑换的余额不正确,最低为0.01']);
        }
        // 用户积分是否足够
        if($user['points'] <= 0) {
            throw new BaseException(['msg' => '当前用户没有可用积分']);
        }
        
        // 消耗积分
        $consume_points = $this->getConsumePoints($data);
        if($consume_points > $user['points']) {
            throw new BaseException(['msg' => '当前用户可用积分不足']);
        }
    }

    /**
     * 计算消耗积分
     * @param $data
     * @throws BaseException
     */
    private function getConsumePoints($data){
        $ratio = SettingModel::getItem("points")['dealer']['exchange_ratio'];
        // 向上取整
        return (int)ceil($data['balance'] / $ratio);
    }
}