<?php

namespace app\common\model\user;

use app\common\model\BaseModel;
use app\api\model\Setting as SettingModel;

/**
 * 用户签到模型
 * Class SignIn
 * @package app\common\model\user
 */
class SignIn extends BaseModel
{
	protected $name = "user_sign_in";
	protected $createTime = false;
    protected $updateTime = false;

	/**
     * 是否开启签到功能
     * @return mixed
     */
    public static function isOpen()
    {
    	$sign_in = SettingModel::getItem("points")['sign_in'];
        return $sign_in['is_open'];
    }

    /**
     * 获取签到设置
     * @return array
     */
    public static function get_setting()
    {
    	$setting = SettingModel::getItem("points")['sign_in'];
        return $setting;
    }

    /**
     * 新增记录
     * @param $data
     */
    public static function add($data)
    {
        $static = new static;
        $static->save(array_merge(['wxapp_id' => $static::$wxapp_id], $data));
    }
}