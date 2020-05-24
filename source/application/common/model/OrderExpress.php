<?php

namespace app\common\model;

/**
 * 订单多个物流信息模型
 * Class OrderExpress
 * @package app\common\model
 */
class OrderExpress extends BaseModel
{
    protected $name = 'order_express';
    protected $updateTime = false;

    /**
     * 关联物流公司表
     * @return \think\model\relation\BelongsTo
     */
    public function express()
    {
        $module = self::getCalledModule() ?: 'common';
        return $this->belongsTo("app\\{$module}\\model\\Express");
    }

}