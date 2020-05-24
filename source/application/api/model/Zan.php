<?php

namespace app\api\model;
use app\common\model\User as UserModel;


/**
 * 用户模型类
 * Class User
 * @package app\api\model
 */
class Zan extends UserModel
{
   
    /**
     * 隐藏字段
     * @var array
     */
    protected $hidden = [
        
        'create_time',
        'update_time'
    ];
    // 定义时间戳字段名
	protected $autoWriteTimestamp = true;
   


}
