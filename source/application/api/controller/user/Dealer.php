<?php

namespace app\api\controller\user;

use app\api\controller\Controller;
use app\api\model\dealer\Setting;
use app\api\model\dealer\User as DealerUserModel;
use app\api\model\dealer\Apply as DealerApplyModel;
use app\api\controller\user\dealer\Team as TeamController;
use think\Db;
/**
 * 分销中心
 * Class Dealer
 * @package app\api\controller\user
 */
class Dealer extends Controller
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
        $this->dealer = DealerUserModel::detail($this->user['user_id']);
        // 分销商设置
        $this->setting = Setting::getAll();
         //后台职位根据条件初始化写入
        set_dailishang_rank();//代理商晋级主任
        set_zhuren_rank();//主任晋级经理
        set_jingli_rank();//经理晋级总监
        dealerUsertToUser();//dealer_user同步更新到user
    }

     //团队佣金写入到vic_dealer_user的money
    public function save_commission(){
          //达标月度考核的佣金累加到vic_dealer_user的money
        $user_rank=Db::table("vic_user")->where("user_id",$this->user['user_id'])->field("rank")->select()->toArray();
         $user_rank=array_column( $user_rank,"rank");
        if($user_rank[0]>0){
            //佣金
             $commission=(new TeamController())->commission(); 
             if ($commission<=0) {
                 return;
             }
             //佣金追加money的更新时间
            $commission_update_time=Db::table("vic_dealer_user")->where("user_id",$this->user['user_id'])->field("commission_update_time")->select()->toArray();
            $commission_update_time=array_column( $commission_update_time,"commission_update_time");
            
            if ($commission_update_time[0]==0) {
                //佣金累加
                Db::table("vic_dealer_user")->where("user_id",$this->user['user_id'])->setInc("money",$commission);
                //添加佣金更新时间
                Db::table("vic_dealer_user")->where("user_id",$this->user['user_id'])->setField('commission_update_time', time());
            }else{
                $commission_update_time=explode("-",date("Y-m-d",$commission_update_time[0]));
                //返回的是上次更新月份的第一天和最后一天时间戳
                $updatetime= mFristAndLast($commission_update_time[0],$commission_update_time[1]);
                $mon_new=time();//当前时间戳
            
                if($mon_new>$updatetime["firstday"] && $mon_new<$updatetime["lastday"]){
                    return;
                }else{
                    //佣金累加
                    Db::table("vic_dealer_user")->where("user_id",$this->user['user_id'])->setInc("money",$commission);
                    //添加佣金更新时间
                    Db::table("vic_dealer_user")->where("user_id",$this->user['user_id'])->setField('commission_update_time', time());
                }
            }
         }else{
            return;
         }
    }

    /**
     * 分销商中心
     * @return array
     */
    public function center()
    {
        return $this->renderSuccess([
            // 当前是否为分销商
            'is_dealer' => $this->isDealerUser(),
            // 当前用户信息
            'user' => $this->user,
            // 分销商用户信息
            'dealer' => $this->dealer,
            // 背景图
            'background' => $this->setting['background']['values']['index'],
            // 页面文字
            'words' => $this->setting['words']['values'],
        ]);
    }

    /**
     * 分销商申请状态
     * @param null $referee_id
     * @return array
     * @throws \think\exception\DbException
     */
    public function apply($referee_id = null)
    {
        // 推荐人昵称
        $referee_name = '平台';
        if ($referee_id > 0 && ($referee = DealerUserModel::detail($referee_id))) {
            $referee_name = $referee['user']['nickName'];
        }
        return $this->renderSuccess([
            // 当前是否为分销商
            'is_dealer' => $this->isDealerUser(),
            // 当前是否在申请中
            'is_applying' => DealerApplyModel::isApplying($this->user['user_id']),
            // 推荐人昵称
            'referee_name' => $referee_name,
            // 背景图
            'background' => $this->setting['background']['values']['apply'],
            // 页面文字
            'words' => $this->setting['words']['values'],
            // 申请协议
            'license' => $this->setting['license']['values']['license'],
        ]);
    }

    /**
     * 分销商提现信息
     * @return array
     */
    public function withdraw()
    {
        return $this->renderSuccess([
            // 分销商用户信息
            'dealer' => $this->dealer,
            // 结算设置
            'settlement' => $this->setting['settlement']['values'],
            // 背景图
            'background' => $this->setting['background']['values']['withdraw_apply'],
            // 页面文字
            'words' => $this->setting['words']['values'],
        ]);
    }

    /**
     * 当前用户是否为分销商
     * @return bool
     */
    private function isDealerUser()
    {
        return !!$this->dealer && !$this->dealer['is_delete'];
    }

}