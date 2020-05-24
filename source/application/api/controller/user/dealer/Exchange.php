<?php

namespace app\api\controller\user\dealer;

use app\api\controller\Controller;
use app\api\model\dealer\Setting;
use app\api\model\dealer\User as DealerUserModel;
use app\api\model\dealer\Exchange as ExchangeModel;
use app\api\model\Setting as SettingModel;

/**
 * 分销商积分兑换余额
 * Class Withdraw
 * @package app\api\controller\user\dealer
 */
class Exchange extends Controller
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
    }

    /**
     * 积分兑换余额
     * @return array
     * @throws \app\common\exception\BaseException
     */
    public function index(){
        return $this->renderSuccess([
            // 当前是否为分销商
            'is_dealer' => $this->isDealerUser(),
            // 当前用户信息
            'user' => $this->user,
            // 背景图
            'background' => $this->setting['background']['values']['index'],
            // 积分设置
            'setting' => SettingModel::getItem("points")['dealer'],
        ]);
    }

    /**
     * 提交提现申请
     * @param $data
     * @return array
     * @throws \app\common\exception\BaseException
     */
    public function submit($data)
    {
        $formData = json_decode(htmlspecialchars_decode($data), true);
        $model = new ExchangeModel;
        if ($model->submit($this->dealer, $this->user, $formData)) {
            return $this->renderSuccess([], '兑换成功');
        }
        return $this->renderError($model->getError() ?: '兑换失败');
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