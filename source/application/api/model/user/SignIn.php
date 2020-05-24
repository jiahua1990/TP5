<?php

namespace app\api\model\user;

use app\common\model\user\SignIn as SignInModel;
use app\api\model\user\PointsLog as PointsLogModel;

/**
 * 用户签到模型
 * Class SignIn
 * @package app\api\model\user
 */
class SignIn extends SigninModel
{
	/**
     * 签到记录
     * @param $user
     * @param $date(年-月,切换月份)
     * @return array
     * @throws \think\exception\DbException
     */
    public function history($user,$date = null)
    {	
    	$month_between = $this->get_month_between($date);
    	$where['user_id'] = $user['user_id'];
    	$where['sign_time'] = ['between',$month_between];
    	$field = "from_unixtime(sign_time,'%Y,%c,%e') sign_time";
        $history = $this->where($where)->order("sign_time")->field($field)->select();
    	$history = array_column($history->toArray(), "sign_time");

        return $history;
    }

    /**
     * 签到
     * @param $user
     * @param $sign_date
     * @return bool
     * @throws \think\exception\DbException
     * @throws \Exception
     */
    public function sign($user,$sign_date)
    {
    	$sign_date = str_replace(",", "-", $sign_date);
    	// 获取签到设置
    	$sign_set = self::get_setting();

    	// 验证能否签到
    	if(!$this->check_sign($sign_date, $sign_set, $user)) return false;

    	// 计算签到可获取的积分
    	$sign_in = $this->get_points($sign_date, $sign_set, $user);

    	// 签到事件
    	$check =  $this->transaction(function () use ($user,$sign_in) {
    		// 保存连续签到记录
    		$sign_continue = ['sign_day'=>$sign_in['sign_day'],'last_sign_time'=>$sign_in['sign_time']];
            $user->save($sign_continue);
           	
            // 增加用户积分
            $describe = "签到送积分";
            $sign_in['get_points'] > 0 && $user->setIncPoints($sign_in['get_points'], $describe);

            // 保存签到记录
            return SignInModel::add($sign_in);
        });

        if($check !== false) return $sign_in;
        else return false;
    }

	/**
     * 验证能否签到
     * @param $sign_set
     * @param $sign_date
     * @param $user
     * @return bool
     */
    private function check_sign($sign_date, $sign_set, $user)
    {
    	// 是否开启签到
    	if(!$sign_set['is_open']) {
    		$this->error = "签到活动已结束";
    		return false;
    	}

    	$check_date = strtotime($sign_date);

    	// 是否当日签到
    	$now = strtotime(date("Y-m-d",time()));
    	if($now != $check_date){
    		$this->error = "仅限当日签到";
    		return false;
    	}

    	// 是否已签到
    	$last_sign_time = strtotime(date("Y-m-d",$user['last_sign_time']));
    	if($last_sign_time == $check_date){
    		$this->error = "今日已签到";
    		return false;
    	}

    	return true;
    }

    /**
     * 计算签到积分
     * @param $sign_set
     * @param $sign_date
     * @param $user
     * @return array
     */
    private function get_points($sign_date, $sign_set, $user)
    {
    	$check_date = strtotime($sign_date);
    	$last_sign_time = strtotime(date("Y-m-d",$user['last_sign_time']));
    	$interval_day = ($check_date - $last_sign_time)/60/60/24;//签到间隔天数
    	$sign_day = $interval_day == 1 ? ($user['sign_day'] + 1) : 1;//连续签到天数

    	// 日常签到加积分
    	$point_basic = $sign_set['basic_sign_point'];

    	// 额外奖励积分
    	$point_bonus = 0;

    	// 是否首次签到
    	if($user['last_sign_time'] == 0) $point_bonus += $sign_set['first_sign_point'];

    	// 是否符合连签奖励
    	$bonus_sign_point = $sign_set['bonus_sign_point'];
    	if(isset($bonus_sign_point[$sign_day])) $point_bonus += $bonus_sign_point[$sign_day];

    	// 签到获得总积分
    	$get_points = $point_basic + $point_bonus;

    	return ['user_id'=>$user['user_id'],'sign_day'=>$sign_day,'get_points'=>$get_points,'point_basic'=>$point_basic,'point_bonus'=>$point_bonus,'sign_time'=>time()];
    }

    /**
     * 获取某个月第一天和最后一天
     * @param $date(年-月)
     * @return bool
     */
    private function get_month_between($date)
    {
    	$date = $date ? : date("Y-m");//没有指定月份，返回当前月份
		$firstday = date('Y-m-01', strtotime($date));
		$lastday = date('Y-m-d', strtotime("$firstday +1 month -1 day"))." 23:59:59";
		return array(strtotime($firstday), strtotime($lastday));
	}
}