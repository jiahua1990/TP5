<?php

namespace app\store\controller\market;

use app\store\controller\Controller;
use app\store\model\Setting as SettingModel;
use app\store\model\user\PointsLog as PointsLogModel;

/**
 * 积分管理
 * Class Points
 * @package app\store\controller\market
 */
class Points extends Controller
{
    /**
     * 积分设置
     * @return array|bool|mixed
     * @throws \think\exception\DbException
     */
    public function setting()
    {
        if (!$this->request->isAjax()) {
            $values = SettingModel::getItem('points');
            ksort($values['sign_in']['bonus_sign_point']);
            return $this->fetch('setting', compact('values'));
        }
        $model = new SettingModel;
        $data = $this->postData('points');

        if(!isset($data['sign_in']['bonus_sign_point'])) $data['sign_in']['bonus_sign_point'] = [];
        $bonus_rule = [];
        foreach ($data['sign_in']['bonus_sign_point'] as $val) {
            $bonus_rule[$val['day']] = $val['bonus'];
        }
        $data['sign_in']['bonus_sign_point'] = $bonus_rule;
        
        if ($model->edit('points', $data)) {
            return $this->renderSuccess('操作成功');
        }
        return $this->renderError($model->getError() ?: '操作失败');
    }

    /**
     * 积分明细
     * @return mixed
     * @throws \think\exception\DbException
     */
    public function log()
    {
        // 积分明细列表
        $model = new PointsLogModel;
        $list = $model->getList($this->request->param());
        return $this->fetch('log', compact('list'));
    }

}