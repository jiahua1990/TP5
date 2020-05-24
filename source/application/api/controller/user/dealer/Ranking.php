<?php

namespace app\api\controller\user\dealer;

use app\api\controller\Controller;
use app\api\model\dealer\User as DealerUserModel;
use think\Db;
/**
 * 业绩排名
 * Class Order
 * @package app\api\controller\user\dealer
 */
class Ranking extends Controller
{
    /* @var \app\api\model\User $user */
    private $user;

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
       
    }

    /**
     * 我的月度排名
     * @param int $level
     * @return array
     * @throws \think\exception\DbException
     */
    public function month_rank()
    {
        return [
            // 月度排名
            'month_rank' => $this->month_all_rank($time="month",$user_order_type=false),
        ];
    }
    public function zong_rank()
    {
        return [
            // 总排名
            'zong_rank' => $this->month_all_rank(),
        ];
    }

     /**
     * 团队销售额
     * @param string $time  时间查询 /默认查询全部/month查询本月
     * @return float number
     * $user_order_type  true 查询全部数据；false查询月度的订单
     */
    public function month_all_rank($time="",$user_order_type=true){
         //$rank_all_user=array();
        $t=$time;
        $user_order_types=$user_order_type;

        $user_rank= DealerUserModel::where(["user_id"=>$this->user['user_id']])->field("rank")->select()->toArray();
        $user_rank=array_column($user_rank,"rank"); 
         
        $dealer_userid=Db::table("vic_user")->where("rank",$user_rank[0])->where("is_delete",0)->field("user_id,rank")->select()->toArray();
    
        foreach ($dealer_userid as $key => $value) {
            //育成销售额
            $yucheng_money=$this->xiaxian_total_moneys($time=$t,$type="=",$user_id=$value["user_id"],$rank=$value["rank"],$type_month=$user_order_types);
                 
            //直辖销售额
            $zhixia_money=$this->xiaxian_total_moneys($time=$t,$type="<",$user_id=$value["user_id"],$rank=$value["rank"],$type_month=$user_order_types);
          
            //父级自己的销售额
            if ($user_order_types) {
                //总销售额
               $farther_money=Db::table("vic_user")->where("user_id",$value["user_id"])->where("is_delete",0)->field("expend_money")->select()->toArray();
               if (count($farther_money)>0) {
                    $farther_money=floatval(array_column($farther_money,"expend_money")[0]);
                }else{
                    $farther_money=0;
                }    
            }else{
                //月度销售额
                $farther_money=Db::table("vic_order")->where("user_id",$value["user_id"])->where(["is_delete"=>0,"order_status"=>30])->whereTime("receipt_time", $t)->field("pay_price")->select()->toArray();
                if (count($farther_money)>0) {
                    $farther_money=floatval(array_column($farther_money,"pay_price")[0]);
                }else{
                    $farther_money=0;
                }                 
            }
           
           
            //团队销售额
            $money=$zhixia_money+$yucheng_money+$farther_money;
        
            $rank_all_user[$key]= Db::table('vic_user')->where(["user_id"=>$value['user_id']])->field("nickName,avatarUrl")->select()->toArray();
            $rank_all_user[$key]["money"]= sprintf("%01.2f", $money);;
            $rank_all_user[$key]["rank"]= $user_rank[0];

        }
       
        
        //进行倒叙处理(二维数组排序）
        $money = array_column($rank_all_user,'money');
        array_multisort($money,SORT_DESC,$rank_all_user);
        return $rank_all_user;
    }

   public function xiaxian_total_moneys($time="",$type="<",$user_id,$rank,$type_month){
       //所有下线
       $referee_userid=Db::table('vic_dealer_referee')
                ->alias('a')
                ->join('vic_user b','a.user_id = b.user_id')
                ->join('vic_dealer_user c','c.user_id = a.dealer_id')
                ->field("a.user_id")
                ->where("c.is_delete=0 and  b.is_delete=0")
                ->where(["a.dealer_id"=>$user_id])
                ->select()
                ->toArray();
        $referee_userid=array_column($referee_userid,"user_id");
            
        //直辖团队
        $zhixia_user=Db::table('vic_user')->where("user_id","in",$referee_userid)->where("rank",$type,$rank)->field("user_id,rank")->select()->toArray();
           
        //直辖下的所有user_id
        $zhixia_users=zhiwei_jinji_userids($zhixia_user);
       
         $xiaxain_total_money=0;
         if (count($zhixia_users)>0) {
             //直辖的下线总消费 
             if ($type_month) {
                $xiaxain_money=Db::table("vic_user")->where("user_id","in",$zhixia_users)->where("is_delete",0)->whereTime("update_time", $time)->field("expend_money")->select(); 
                foreach ($xiaxain_money as $key => $value) {
                    $xiaxain_total_money+=floatval($value["expend_money"]);
                }
             }else{
                $xiaxain_money=Db::table("vic_order")->where("user_id","in",$zhixia_users)->where(["is_delete"=>0,"order_status"=>30])->whereTime("receipt_time", $time)->field("pay_price")->select()->toArray(); 
                foreach ($xiaxain_money as $key => $value) {
                    $xiaxain_total_money+=floatval($value["pay_price"]);
                }
             }
            
            
         }
          
        return $xiaxain_total_money;
    }
   
    

}