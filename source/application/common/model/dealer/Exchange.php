<?php

namespace app\common\model\dealer;

use app\common\model\BaseModel;

/**
 * 分销商积分兑换余额模型
 * Class Apply
 * @package app\common\model\dealer
 */
class Exchange extends BaseModel
{
    protected $name = 'user_points_exchange';

    /**
     * 兑换详情
     * @param $id
     * @return Apply|static
     * @throws \think\exception\DbException
     */
    public static function detail($id)
    {
        return self::get($id);
    }

}