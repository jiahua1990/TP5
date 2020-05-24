<div class="row-content am-cf">
    <div class="row">
        <div class="am-u-sm-12 am-u-md-12 am-u-lg-12">
            <div class="widget am-cf">
                <div class="widget-head am-cf">
                    <div class="widget-title am-cf">下级用户列表</div>
                </div>
                <div class="widget-body am-fr">
                    <!-- 工具栏 -->
                    <div class="am-scrollable-horizontal am-u-sm-12 am-padding-top">
                        <table width="100%" class="am-table am-table-compact am-table-striped
                         tpl-table-black am-text-nowrap">
                            <thead>
                            <tr>
                                <th>用户ID</th>
                                <th>微信头像</th>
                                <th>微信昵称</th>
                                <th>当前职位</th>
                                <th>性别</th>
                                <th>累积消费金额</th>
                                <th>注册时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <?php if (!$list->isEmpty()): foreach ($list as $item): ?>
                                <tr>
                                    <td class="am-text-middle"><?= $item['user']['user_id'] ?></td>
                                    <td class="am-text-middle">
                                        <a href="<?= $item['user']['avatarUrl'] ?>" title="点击查看大图" target="_blank">
                                            <img src="<?= $item['user']['avatarUrl'] ?>"
                                                 width="50" height="50" alt="">
                                        </a>
                                    </td>
                                    <td class="am-text-middle">
                                        <p><span><?= $item['user']['nickName'] ?></span></p>
                                    </td>
                                    <td class="am-text-middle">
                                         <span> <?php switch($item['user']['rank']){
                                            case 0: echo"会员"; break;
                                            case 1: echo"代理商"; break;
                                            case 2: echo"销售主任"; break;
                                            case 3: echo"销售经理"; break;
                                            case 4: echo"区域总监"; break;
                                            } ?>
                                            </span>
                                    </td>
                                    <td class="am-text-middle"><?= $item['user']['gender'] ?></td>
                                    <td class="am-text-middle"><?= $item['user']['expend_money'] ?></td>
                                    <td class="am-text-middle"><?= $item['create_time'] ?></td>
                                    <td class="am-text-middle">
                                        <div class="tpl-table-black-operation">
                                            <?php if (checkPrivilege('apps.dealer.user/change_referee')): ?>
                                                <a class="j-change" data-id="<?= $item['id'] ?>"
                                                   href="javascript:void(0);">
                                                    <i class="am-icon-pencil"></i> 更换上级分销商
                                                </a>
                                            <?php endif; ?>
                                        </div>
                                    </td>
                                </tr>
                            <?php endforeach; else: ?>
                                <tr>
                                    <td colspan="6" class="am-text-center">暂无记录</td>
                                </tr>
                            <?php endif; ?>
                            </tbody>
                        </table>
                        <div class="am-u-lg-12 am-cf">
                            <div class="am-fr"><?= $list->render() ?> </div>
                            <div class="am-fr pagination-total am-margin-right">
                                <div class="am-vertical-align-middle">总记录：<?= $list->total() ?></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script id="tpl-copyForm" type="text/html">
    <div class="am-padding-top-sm">
        <form class="j-copyForm am-form tpl-form-line-form">
            <div class="am-form-group">
                <label class="am-u-sm-3 am-form-label"> 分销商用户ID </label>
                <div class="am-u-sm-8 am-u-end">
                    <input type="number" class="j-user_id tpl-form-input" name="user_id" required>
                    <small>可在 <a href="<?= url('apps.dealer.user/index') ?>" target="_blank">分销中心 - 分销商用户</a> 中查看
                    </small>
                </div>
            </div>
        </form>
    </div>
</script>

<script>
    $(function () {
        /**
         * 更换分销商
         */
        $('.j-change').click(function () {
            var id = $(this).data("id");
            var $copyForm = $('#tpl-copyForm');
            layer.open({
                type: 1
                , title: '更换分销商'
                , area: '340px'
                , offset: 'auto'
                , anim: 1
                , closeBtn: 1
                , shade: 0.3
                , btn: ['确定', '取消']
                , content: $copyForm.html()
                , success: function (layero) {

                }
                , yes: function (index, layero) {
                    var userId = layero.find('.j-user_id').val();
                    if (userId > 0) {
                        $.post("<?= url('apps.dealer.user/change_referee') ?>"
                        , {
                            id: id,
                            user_id: userId,
                        }
                        , function (result) {
                            result.code === 1 ? $.show_success(result.msg, result.url)
                                : layer.alert(result.msg);
                            if(result.code === 1) layer.close(index);
                        });
                    }else{
                        layer.alert("请填写分销商用户ID");
                    }
                }
            });
        });
    });
</script>

