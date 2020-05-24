<?php

namespace app\api\controller\user;

use app\api\controller\Controller;

use app\api\model\Order as OrderModel;
use app\api\model\User as UserModel;
use think\Cache;
use think\Db;
use think\Request;
/**
 * 用户订单管理
 * Class Order
 * @package app\api\controller\user
 */
class Rollanduser extends Controller
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
        $this->user = $this->getUser();   // 用户信息
    }

    
    /**
     * 滚动数据
     * @param $order_id
     * @return array
     * @throws \app\common\exception\BaseException
     * @throws \think\exception\DbException
     */
    public function rolldata()
    {
        // 滚动数据
        $model = OrderModel::field("order_status,pay_price,user_id")->where("order_status",30)->where("pay_price",">",1)->order("order_id desc")->limit(10)->select();

        foreach ($model as $key => $value) {
            $user_info=UserModel::where("user_id",$value["user_id"])->field("nickName,avatarUrl")->find();
            $result[$key]["user_name"]=$user_info["nickName"];
            $result[$key]["avatarUrl"]=$user_info["avatarUrl"];
            $result[$key]['love_price']=round(($value["pay_price"]*0.05),2);
        }
        return $result;
    }
    //用户昵称。头像及捐赠额
     public function user_detail()
    {
        $user=$this->user;
       $result["avatarUrl"]=$user["avatarUrl"];
       $result["nickName"]=$user["nickName"];
       $result["zong_love_money"]=round($user['pay_money']*0.05,2);
        return $result;
    }
    //爱心排名
    public function love_rank(Request $request)
    {
        $user=$this->user;
        $page_key=intval($request->param('page_key'));
      
        $result=UserModel::where("pay_money",">",1)->where("is_delete",0)->field("nickName,avatarUrl,pay_money,user_id")->order("pay_money desc")->page("".$page_key.",20")->select(); 
        foreach ($result as $key => $value) {

            $results[$key]["love_money"]=round($value["pay_money"]*0.05,2);
            $results[$key]["nickName"]=$value["nickName"];
            $results[$key]["avatarUrl"]=$value["avatarUrl"];
            $results[$key]["user_id"]=$value["user_id"];
            
            $zansum=Db::name("zansum")->where("zan_id",$value["user_id"])->field("zan_sum")->find();
            if (!empty($zansum)) {
                 $results[$key]["zan"]= $zansum["zan_sum"];
            }else{
                $results[$key]["zan"]= 0;
            }
           
            $info=Db::name("zan")->where("user_id",$user["user_id"])->field("zan_id,is_show")->select();

            if (!empty($info)) {
                foreach ($info as $k => $v) {   
                    if ($v["is_show"]=="1" && $v["zan_id"]==$value["user_id"]) {
                        $results[$key]["zan_isshow"]=1;
                    }  
                }
                
            }
            
        }
        return $results;
    }

    //点赞
    public function zan(Request $request)
    {
        $user_id=$request->param('user_id');//接受前端的数据
        $zan_id=$request->param('zan_id');
        $is_show=$request->param('isshow');
         
        $zan_exists=Db::name("zan")->where("user_id",$user_id)->where("zan_id",$zan_id)->find();
        if (!empty($zan_exists)) {
             Db::name("zan")->where("user_id",$user_id)->where("zan_id",$zan_id)->setField('is_show', $is_show);
            if($is_show=="1"){
                
                Db::name("zansum")->where("zan_id",$zan_id)->setInc('zan_sum');
                
            }else{
                 Db::name("zansum")->where("zan_id",$zan_id)->setDec('zan_sum'); 
            }
            return ["statusCode"=>200];
           
        }else{
            $data=[
            "user_id"=>$user_id,
            "zan_id"=>$zan_id,
            "is_show"=>$is_show,
            "update_time"=>time(),
            "create_time"=>time()
            ];
            Db::name("zan")->insert($data);

            $info=Db::name('zansum')->where('zan_id',$zan_id)->field('zan_sum')->find();
            if (!empty($info)) {
                Db::name('zansum')->where('zan_id',$zan_id)->inc('zan_sum')->update();
            }else{
                $zansum=[
                    "zan_id"=>$zan_id,
                    "zan_sum"=>1,
                ];
                Db::name("zansum")->insert($zansum);
            }
            
           return ["statusCode"=>200];
        }  
          
    }

}
