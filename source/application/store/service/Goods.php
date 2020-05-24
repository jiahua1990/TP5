<?php

namespace app\store\service;

use app\common\service\Goods as Bases;
use app\store\model\Category as CategoryModel;
use app\store\model\Delivery as DeliveryModel;
use app\store\model\user\Grade as GradeModel;
use app\store\model\Goods as GoodsModel;

/**
 * 商品服务类
 * Class Goods
 * @package app\store\service
 */
class Goods extends Bases
{
    /**
     * 商品管理公共数据
     * @param GoodsModel|null $model
     * @return array
     */
    public static function getEditData($model = null)
    {
        // 商品分类
        $catgory = CategoryModel::getCacheTree();
        // 配送模板
        $delivery = DeliveryModel::getAll();
        // 会员等级列表
        $gradeList = GradeModel::getUsableList();
        // 商品sku数据
        $specData = 'null';
        if (!is_null($model) && $model['spec_type'] == 20) {
            $specData = json_encode($model->getManySpecData($model['spec_rel'], $model['sku']));
        }
        return compact('catgory', 'delivery', 'gradeList', 'specData');
    }


}