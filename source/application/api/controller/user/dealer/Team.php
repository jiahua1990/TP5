<?php

namespace app\api\controller\user\dealer;

use app\api\controller\Controller;
use app\api\model\dealer\Setting;
use app\api\model\dealer\User as DealerUserModel;
use app\api\model\dealer\Referee as RefereeModel;
use think\Db;
/**
 * 我的团队
 * Class Order
 * @package app\api\controller\user\dealer
 */
class Team extends Controller
{
    /* @var \app\api\model\User $user */
    private $user;

    private $dealer;
    private $setting;

    /**
     * 构造方法
     * @throws \app\common\exception\BaseException
     * @throws \think\exception\DbException
     */
    public function _initialize()
    {
        parent::_initialize();
        // 用户信息
        $this->user = $this->getUser();
        // 分销商用户信息
        $this->dealer = $this->getDealer();
        // 分销商设置
        $this->setting = Setting::getAll();
       
    }

    private function getDealer()
    {
        $dealer = DealerUserModel::detail($this->user['user_id']);
        $level_user = $dealer->toArray()['level_user'];
        $dealer['first_num'] = 0;
        $dealer['second_num'] = 0;
        $dealer['third_num'] = 0;
        foreach ($level_user as $key => $val) {
            if($val['level'] == 1) $dealer['first_num'] += 1;
            elseif($val['level'] == 2) $dealer['second_num'] += 1;
            elseif($val['level'] == 3) $dealer['third_num'] += 1;
        }
        unset($dealer['level_user']);
        return $dealer;
    }

    /**
     * 我的团队列表
     * @param int $level
     * @return array
     * @throws \think\exception\DbException
     */
    public function lists($level = -1)
    {
        $model = new RefereeModel;
        return $this->renderSuccess([
            // 分销商用户信息
            'dealer' => $this->dealer,
            // 我的团队列表
            'list' => $model->getList($this->user['user_id'], (int)$level),
            // 基础设置
            'setting' => $this->setting['basic']['values'],
            // 页面文字
            'words' => $this->setting['words']['values'],
            // 团队佣金
            'get_group_commission' => $this->commission(),
        ]);
    }

    //团队佣金
    public function commission(){
        $user_rank= DealerUserModel::where(["user_id"=>$this->user['user_id'],"is_delete"=>0])->field("rank")->select()->toArray();

          if (count($user_rank)>0) {
              $user_rank=array_column($user_rank,"rank");
              if ($user_rank[0]==1) {
                 $comission=0;
                 return $comission;
              }
          }else{
            return;
          }
      
       //直辖和育成的月度销售额
       $yuedu_total=($this->zhixia_yucheng_month_money())+($this->zhixia_yucheng_month_money("="));
       //直辖月度销售额
       $yuedu_zhixia_total=$this->zhixia_yucheng_month_money();

       //佣金比例
       $group_commission=$this->setting['group_commission']['values'];
       
       //直辖销售总额
       $zhixia_total=$this->zhixia_yucheng_total_money();
       //育成销售总额
       $yucheng_total=$this->zhixia_yucheng_total_money("=");
       //团队佣金
       $comission=0;
        switch ($user_rank[0])
        {
        case 2://主任
            if ($yuedu_zhixia_total>=intval($group_commission["zhuren_yuedu_money"])) {
                $comission = $zhixia_total/100*intval($group_commission["zhixia_zhuren_proportion"]);
            }
            break;
        case 3://经理
            if ($yuedu_total>=intval($group_commission["jingli_yuedu_money"])) {
                $comission = $zhixia_total/100*intval($group_commission["zhixia_jingli_proportion"])+$yucheng_total/100*intval($group_commission["yucheng_jingli_proportion"]);
            }
            break;
        case 4://总监
            if ($yuedu_total>=intval($group_commission["zongjian_yuedu_money"])) {
                $comission = $zhixia_total/100*intval($group_commission["zhixia_zongjian_proportion"])+$yucheng_total/100*intval($group_commission["yucheng_zongjian_proportion"]);
            }
            break;
        default:
             $comission=0;
        }

        return  round($comission,2);
    }
    
     /**
     * 团队总销售额
     * @param string $time  时间查询 /默认查询全部/month查询本月
     * @param string $type 直辖或育成  /默认是直辖/ "="是育成
     * @return float number
     * 
     */
    public function zhixia_yucheng_total_money($type="<"){
       $user_rank= DealerUserModel::where(["user_id"=>$this->user['user_id']])->field("rank")->select()->toArray();
       $user_rank=array_column($user_rank,"rank");
       
       //所有下线
       $referee_userid=Db::table('vic_dealer_referee')
                ->alias('a')
                ->join('vic_user b','a.user_id = b.user_id')
                ->join('vic_dealer_user c','c.user_id = a.dealer_id')
                ->field("a.user_id")
                ->where("c.is_delete=0 and  b.is_delete=0")
                ->where(["a.dealer_id"=>$this->user['user_id']])
                ->select()
                ->toArray();
        $referee_userid=array_column($referee_userid,"user_id");
            
        //直辖团队
        $zhixia_user=Db::table('vic_user')->where("user_id","in",$referee_userid)->where("rank",$type,$user_rank[0])->field("user_id,rank")->select()->toArray();
            
        //直辖下的所有user_id
        $zhixia_users=zhiwei_jinji_userids($zhixia_user);

        static $xiaxain_total_money=0;
        //if (count($zhixia_users)>0) {
                //直辖的下线总消费
            $xiaxain_money=Db::table("vic_user")->where("user_id","in",$zhixia_users)->where("is_delete",0)->field("expend_money")->select()->toArray(); 
            if (count($xiaxain_money)<=0) {
                return;
            }
            foreach ($xiaxain_money as $key => $value) {
                $xiaxain_total_money+=floatval($value["expend_money"]);
            }

        //}
 
        return $xiaxain_total_money;
    }
    //月度销售额
    //订单表每月完成  (收货时间receipt_time)
    public function zhixia_yucheng_month_money($type="<",$time="last month"){
       $user_rank= DealerUserModel::where(["user_id"=>$this->user['user_id']])->field("rank")->select()->toArray();
       $user_rank=array_column($user_rank,"rank");
       //所有下线
       $referee_userid=Db::table('vic_dealer_referee')
                ->alias('a')
                ->join('vic_user b','a.user_id = b.user_id')
                ->join('vic_dealer_user c','c.user_id = a.dealer_id')
                ->field("a.user_id")
                ->where("c.is_delete=0 and  b.is_delete=0")
                ->where(["a.dealer_id"=>$this->user['user_id']])
                ->select()
                ->toArray();
        $referee_userid=array_column($referee_userid,"user_id");
        //直辖团队
        $zhixia_user=Db::table('vic_user')->where("user_id","in",$referee_userid)->where("rank",$type,$user_rank[0])->field("user_id,rank")->select()->toArray();
            
        //直辖下的所有user_id
        $zhixia_users=zhiwei_jinji_userids($zhixia_user);
        static $xiaxain_total_money=0;
        //if (count($zhixia_users)>0) {
                //直辖的下线总消费
            $xiaxain_money=Db::table("vic_order")->where("user_id","in",$zhixia_users)->where(["is_delete"=>0,"order_status"=>30])->whereTime("receipt_time", $time)->field("pay_price")->select()->toArray(); 

            if (count($xiaxain_money)<=0) {
                return;
            }
            
            foreach ($xiaxain_money as $key => $value) {
                $xiaxain_total_money+=floatval($value["pay_price"]);
            }

        //}
        return $xiaxain_total_money;
    }
   
    

}