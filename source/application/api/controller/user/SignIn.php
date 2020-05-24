<?php

namespace app\api\controller\user;

use app\api\controller\Controller;
use app\api\model\user\SignIn as SignInModel;

/**
 * 签到得积分
 * Class Log
 * @package app\api\controller\balance
 */
class SignIn extends Controller
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
     * 签到记录
     * @return array
     * @throws \app\common\exception\BaseException
     * @throws \think\exception\DbException
     */
    public function history(){
    	$userInfo = $this->user;
    	$model = new SignInModel;
    	$setting = $model->get_setting();
    	$history = $model->history($this->user,request()->param('date'));
    	$userInfo['last_sign_time'] = date("Y,n,j",$userInfo['last_sign_time']);
    	return $this->renderSuccess(compact("userInfo","setting","history"));
    }

    /**
     * 签到
     * @return array
     * @param $sign_date
     * @throws \app\common\exception\BaseException
     * @throws \think\exception\DbException
     */
    public function sign($sign_date){
    	// 签到
    	$model = new SignInModel;
    	if($data = $model->sign($this->user,$sign_date))
    		return $this->renderSuccess($data,$model->getError() ? : "签到成功");

    	return $this->renderError($model->getError() ? : "签到失败");
    }
}