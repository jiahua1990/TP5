<div class="row-content am-cf">
    <div class="row">
        <div class="am-u-sm-12 am-u-md-12 am-u-lg-12">
            <div class="widget am-cf">
                <form id="my-form" class="am-form tpl-form-line-form" method="post">
                    <div class="widget-body">
                        <fieldset>
                            <div class="widget-head am-cf">
                                <div class="widget-title am-fl">积分设置</div>
                            </div>
                            <div class="am-form-group">
                                <label class="am-u-sm-3 am-u-lg-2 am-form-label form-require"> 积分名称 </label>
                                <div class="am-u-sm-9 am-u-md-6 am-u-lg-5 am-u-end">
                                    <input type="text" class="tpl-form-input" name="points[points_name]"
                                           value="<?= $values['points_name'] ?>" required>
                                    <div class="help-block">
                                        <small>注：修改积分名称后，在买家端看到的都是自定义的名称</small>
                                    </div>
                                </div>
                            </div>
                            <div class="am-form-group">
                                <label class="am-u-sm-3  am-u-lg-2 am-form-label form-require"> 积分说明 </label>
                                <div class="am-u-sm-9 am-u-end">
                                    <textarea rows="5" name="points[describe]"
                                              placeholder="请输入积分说明/规则"><?= $values['describe'] ?></textarea>
                                </div>
                            </div>

                            <div class="widget-head am-cf">
                                <div class="widget-title am-fl">积分赠送</div>
                            </div>
                            <div class="am-form-group am-padding-top">
                                <label class="am-u-sm-3  am-u-lg-2 am-form-label form-require"> 是否开启购物送积分 </label>
                                <div class="am-u-sm-9 am-u-end">
                                    <label class="am-radio-inline">
                                        <input type="radio" name="points[is_shopping_gift]" value="1" data-am-ucheck
                                            <?= $values['is_shopping_gift'] ? 'checked' : '' ?>> 开启
                                    </label>
                                    <label class="am-radio-inline">
                                        <input type="radio" name="points[is_shopping_gift]" value="0" data-am-ucheck
                                            <?= $values['is_shopping_gift'] ? '' : 'checked' ?>> 关闭
                                    </label>
                                    <div class="help-block">
                                        <small>注：如开启则订单完成后赠送用户积分</small>
                                    </div>
                                </div>
                            </div>
                            <div class="am-form-group">
                                <label class="am-u-sm-3 am-u-lg-2 am-form-label form-require"> 积分赠送比例 </label>
                                <div class="am-u-sm-9 am-u-md-6 am-u-lg-5 am-u-end">
                                    <div class="am-input-group">
                                        <input type="number" name="points[gift_ratio]"
                                               class="am-form-field" min="0"
                                               value="<?= $values['gift_ratio'] ?>" required>
                                        <span class="am-input-group-label am-input-group-label__right">%</span>
                                    </div>
                                    <div class="help-block">
                                        <small>注：赠送比例请填写数字0~100；订单的运费不参与积分赠送</small>
                                    </div>
                                    <div class="help-block">
                                        <small>例：订单付款金额(100.00元) * 积分赠送比例(100%) = 实际赠送的积分(100积分)</small>
                                    </div>
                                </div>
                            </div>

                            <div class="widget-head am-cf">
                                <div class="widget-title am-fl">积分抵扣</div>
                            </div>
                            <div class="tips am-margin-bottom-sm am-u-sm-12">
                                <div class="pre">
                                    <p> 注：积分抵扣最多抵扣到0.01元</p>
                                </div>
                            </div>
                            <div class="am-form-group am-padding-top">
                                <label class="am-u-sm-3  am-u-lg-2 am-form-label form-require"> 是否允许积分抵扣 </label>
                                <div class="am-u-sm-9 am-u-end">
                                    <label class="am-radio-inline">
                                        <input type="radio" name="points[is_shopping_discount]" value="1" data-am-ucheck
                                            <?= $values['is_shopping_discount'] ? 'checked' : '' ?>> 允许
                                    </label>
                                    <label class="am-radio-inline">
                                        <input type="radio" name="points[is_shopping_discount]" value="0" data-am-ucheck
                                            <?= $values['is_shopping_discount'] ? '' : 'checked' ?>> 不允许
                                    </label>
                                    <div class="help-block">
                                        <small>注：如开启则用户下单时可选择使用积分抵扣订单金额</small>
                                    </div>
                                    <div class="help-block">
                                        <small>注：此开关是管理所有的商品是否使用积分抵扣功能</small>
                                    </div>
                                </div>
                            </div>
                            <div class="am-form-group">
                                <label class="am-u-sm-3 am-u-lg-2 am-form-label form-require"> 积分抵扣比例 </label>
                                <div class="am-u-sm-9 am-u-md-6 am-u-lg-5 am-u-end">
                                    <div class="am-input-group">
                                        <span class="am-input-group-label am-input-group-label__left">1个积分可抵扣</span>
                                        <input type="number" class="am-form-field" min="0"
                                               name="points[discount][discount_ratio]"
                                               value="<?= $values['discount']['discount_ratio'] ?>" required>
                                        <span class="am-input-group-label am-input-group-label__right">元</span>
                                    </div>
                                    <div class="help-block">
                                        <small>例如：1积分可抵扣0.01元，100积分则可抵扣1元，1000积分则可抵扣10元</small>
                                    </div>
                                </div>
                            </div>

                            <div class="widget-head am-cf">
                                <div class="widget-title am-fl">积分签到</div>
                            </div>
                            <div class="am-form-group am-padding-top">
                                <label class="am-u-sm-3  am-u-lg-2 am-form-label form-require"> 是否开启签到送积分 </label>
                                <div class="am-u-sm-9 am-u-end">
                                    <label class="am-radio-inline">
                                        <input type="radio" name="points[sign_in][is_open]" value="1" data-am-ucheck
                                            <?= $values['sign_in']['is_open'] ? 'checked' : '' ?>> 开启
                                    </label>
                                    <label class="am-radio-inline">
                                        <input type="radio" name="points[sign_in][is_open]" value="0" data-am-ucheck
                                            <?= $values['sign_in']['is_open'] ? '' : 'checked' ?>> 关闭
                                    </label>
                                </div>
                            </div>
                            <div class="am-form-group">
                                <label class="am-u-sm-3 am-u-lg-2 am-form-label form-require"> 签到赠送 </label>
                                <div class="am-u-sm-9 am-u-md-6 am-u-lg-5 am-u-end">
                                    <div class="am-input-group">
                                        <input type="number" class="am-form-field" min="1"
                                               name="points[sign_in][basic_sign_point]"
                                               value="<?= $values['sign_in']['basic_sign_point'] ?>" required>
                                        <span class="am-input-group-label am-input-group-label__right">积分</span>
                                    </div>
                                </div>
                            </div>
                            <div class="am-form-group">
                                <label class="am-u-sm-3 am-u-lg-2 am-form-label form-require"> 首次签到额外赠送 </label>
                                <div class="am-u-sm-9 am-u-md-6 am-u-lg-5 am-u-end">
                                    <div class="am-input-group">
                                        <input type="number" class="am-form-field" min="0"
                                               name="points[sign_in][first_sign_point]"
                                               value="<?= $values['sign_in']['first_sign_point'] ?>" required>
                                        <span class="am-input-group-label am-input-group-label__right">积分</span>
                                    </div>
                                </div>
                            </div>
                            <div class="am-form-group">
                                <label class="am-u-sm-3 am-u-lg-2 am-form-label form-require"> 连续签到奖励 </label>
                                <div class="am-u-sm-9 am-u-end">
                                    <div class="am-form-file">
                                        <div class="am-form-file">
                                            <button type="button" class="upload-file am-btn am-btn-secondary am-radius" id="add_bonus_rule">
                                                添加规则
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="am-form-group">
                                <label class="am-u-sm-3 am-u-lg-2 am-form-label"></label>
                                <div class="am-u-sm-9 am-u-md-6 am-u-lg-5 am-u-end point_bonus_rule">
                                    {{foreach name="$values['sign_in']['bonus_sign_point']" item="vo" key="k" index="i"}}
                                    <div class="am-input-group" style="margin-bottom: 10px;">
                                        <span class="am-input-group-label am-input-group-label__left">连续签到</span>
                                        <input type="number" class="am-form-field" min="1"
                                               name="points[sign_in][bonus_sign_point][{{$i}}][day]"
                                               value="{{$k}}" required>
                                        <span class="am-input-group-label am-input-group-label__center">天，奖励</span>
                                        <input type="number" class="am-form-field" min="1"
                                               name="points[sign_in][bonus_sign_point][{{$i}}][bonus]"
                                               value="{{$vo}}" required>
                                        <span class="am-input-group-label am-input-group-label__right">积分</span>
                                        <span class="am-input-group-label del_bonus_rule">删除</span>
                                    </div>
                                    {{/foreach}}
                                </div>
                            </div>

                            <div class="widget-head am-cf">
                                <div class="widget-title am-fl">分销商积分兑换余额</div>
                            </div>
                            <div class="am-form-group am-padding-top">
                                <label class="am-u-sm-3  am-u-lg-2 am-form-label form-require"> 是否开启积分兑换余额 </label>
                                <div class="am-u-sm-9 am-u-end">
                                    <label class="am-radio-inline">
                                        <input type="radio" name="points[dealer][is_open]" value="1" data-am-ucheck
                                            <?= $values['dealer']['is_open'] ? 'checked' : '' ?>> 开启
                                    </label>
                                    <label class="am-radio-inline">
                                        <input type="radio" name="points[dealer][is_open]" value="0" data-am-ucheck
                                            <?= $values['dealer']['is_open'] ? '' : 'checked' ?>> 关闭
                                    </label>
                                </div>
                            </div>
                            <div class="am-form-group">
                                <label class="am-u-sm-3 am-u-lg-2 am-form-label form-require"> 积分兑换比例 </label>
                                <div class="am-u-sm-9 am-u-md-6 am-u-lg-5 am-u-end">
                                    <div class="am-input-group">
                                        <span class="am-input-group-label am-input-group-label__left">1积分可兑换</span>
                                        <input type="number" class="am-form-field" min="0"
                                               name="points[dealer][exchange_ratio]"
                                               value="<?= $values['dealer']['exchange_ratio'] ?>" required>
                                        <span class="am-input-group-label am-input-group-label__right">余额</span>
                                    </div>
                                </div>
                            </div>


                            <div class="am-form-group">
                                <div class="am-u-sm-9 am-u-sm-push-3 am-margin-top-lg">
                                    <button type="submit" class="j-submit am-btn am-btn-secondary">提交
                                    </button>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    $(function () {

        /**
         * 表单验证提交
         * @type {*}
         */
        $('#my-form').superForm();

        // 添加连续签到奖励规则
        var rule_num = $(".point_bonus_rule").children().length;
        $("#add_bonus_rule").on("click",function(){
            rule_num += 1;
            var html =  '<div class="am-input-group" style="margin-bottom: 10px;">'+
                            '<span class="am-input-group-label am-input-group-label__left">连续签到</span>'+
                            '<input type="number" class="am-form-field" min="1" name="points[sign_in][bonus_sign_point]['+rule_num+'][day]" value="" required>'+
                            '<span class="am-input-group-label am-input-group-label__center">天，奖励</span>'+
                            '<input type="number" class="am-form-field" min="1" name="points[sign_in][bonus_sign_point]['+rule_num+'][bonus]" value="" required>'+
                            '<span class="am-input-group-label am-input-group-label__right">积分</span>'+
                            '<span class="am-input-group-label del_bonus_rule">删除</span>'+
                        '</div>';
            $(".point_bonus_rule").append(html);
        })

        $(document).on("click",".del_bonus_rule",function(){
            $(this).parent("div").remove();
        })
    });
</script>
