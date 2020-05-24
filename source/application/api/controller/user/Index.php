<?php

namespace app\api\controller\user;

use app\api\controller\Controller;
use app\api\model\Order as OrderModel;
use app\api\model\Setting as SettingModel;
use app\api\model\UserCoupon as UserCouponModel;
use app\api\model\dealer\User as DealerUserModel;
use app\api\model\dealer\Setting as DealerSettingModel;
use app\api\controller\user\dealer\Team as TeamController;
use app\api\controller\user\Dealer as DealerController;

use think\Db;
/**
 * 个人中心主页
 * Class Index
 * @package app\api\controller\user
 */
class Index extends Controller
{
    public function _initialize()
    {
        parent::_initialize();
        // 团队佣金
        (new DealerController())->save_commission();
        
    }



    /**
     * 获取当前用户信息
     * @return array
     * @throws \app\common\exception\BaseException
     * @throws \think\Exception
     * @throws \think\exception\DbException
     */
    public function detail()
    {
        // 当前用户信息
        $user = $this->getUser();
        // 订单总数
        $model = new OrderModel;

        //分销佣金
        $dealer = DealerUserModel::detail($user['user_id']);
        $dealer['is_open'] = DealerSettingModel::isOpen();

        return $this->renderSuccess([
            'userInfo' => $user,
            'orderCount' => [
                'payment' => $model->getCount($user['user_id'], 'payment'),
                'received' => $model->getCount($user['user_id'], 'received'),
                'comment' => $model->getCount($user['user_id'], 'comment'),
            ],
            'setting' => [
                'points_name' => SettingModel::getPointsName(),
            ],
            // todo: 废弃
            'couponCount' => (new UserCouponModel)->getCount($user['user_id']),
            'menus' => $user->getMenus(),   // 个人中心菜单列表
            'dealer' => $dealer,
        ]);
    }

}
