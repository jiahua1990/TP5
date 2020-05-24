/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.5.62-log : Database - zcanyou_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `vic_admin_user` */

DROP TABLE IF EXISTS `vic_admin_user`;

CREATE TABLE `vic_admin_user` (
  `admin_user_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_name` varchar(255) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(255) NOT NULL DEFAULT '' COMMENT '登录密码',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`admin_user_id`),
  KEY `user_name` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=10002 DEFAULT CHARSET=utf8 COMMENT='超管用户记录表';

/*Table structure for table `vic_article` */

DROP TABLE IF EXISTS `vic_article`;

CREATE TABLE `vic_article` (
  `article_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `article_title` varchar(300) NOT NULL DEFAULT '' COMMENT '文章标题',
  `show_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表显示方式(10小图展示 20大图展示)',
  `category_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '文章分类id',
  `image_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '封面图id',
  `article_content` longtext NOT NULL COMMENT '文章内容',
  `article_sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '文章排序(数字越小越靠前)',
  `article_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '文章状态(0隐藏 1显示)',
  `virtual_views` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '虚拟阅读量(仅用作展示)',
  `actual_views` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '实际阅读量',
  `is_delete` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章记录表';

/*Table structure for table `vic_article_category` */

DROP TABLE IF EXISTS `vic_article_category`;

CREATE TABLE `vic_article_category` (
  `category_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品分类id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '分类名称',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序方式(数字越小越靠前)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10002 DEFAULT CHARSET=utf8 COMMENT='文章分类表';

/*Table structure for table `vic_bargain_active` */

DROP TABLE IF EXISTS `vic_bargain_active`;

CREATE TABLE `vic_bargain_active` (
  `active_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '砍价活动id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `start_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '活动开始时间',
  `end_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '活动结束时间',
  `expiryt_time` int(11) unsigned NOT NULL DEFAULT '1' COMMENT '砍价有效期(单位：小时)',
  `floor_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '砍价底价',
  `peoples` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '帮砍人数',
  `is_self_cut` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '可自砍一刀(0禁止 1允许)',
  `is_floor_buy` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '必须底价购买(0否 1是)',
  `share_title` varchar(500) NOT NULL DEFAULT '' COMMENT '分享标题',
  `prompt_words` varchar(500) NOT NULL DEFAULT '' COMMENT '砍价助力语',
  `actual_sales` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '活动销量(实际的)',
  `initial_sales` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '虚拟销量',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序(数字越小越靠前)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '活动状态(1启用 0禁用)',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`active_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='砍价活动表';

/*Table structure for table `vic_bargain_setting` */

DROP TABLE IF EXISTS `vic_bargain_setting`;

CREATE TABLE `vic_bargain_setting` (
  `key` varchar(30) NOT NULL DEFAULT '' COMMENT '设置项标示',
  `describe` varchar(255) NOT NULL DEFAULT '' COMMENT '设置项描述',
  `values` mediumtext NOT NULL COMMENT '设置内容(json格式)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  UNIQUE KEY `unique_key` (`key`,`wxapp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='砍价活动设置表';

/*Table structure for table `vic_bargain_task` */

DROP TABLE IF EXISTS `vic_bargain_task`;

CREATE TABLE `vic_bargain_task` (
  `task_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '砍价任务id',
  `active_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '砍价活动id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id(发起人)',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `spec_sku_id` varchar(255) NOT NULL DEFAULT '' COMMENT '商品sku标识',
  `goods_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品原价',
  `floor_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '砍价底价',
  `peoples` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '帮砍人数',
  `cut_people` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '已砍人数',
  `section` text NOT NULL COMMENT '砍价金额区间',
  `cut_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '已砍金额',
  `actual_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '实际购买金额',
  `is_floor` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否已砍到底价(0否 1是)',
  `end_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '任务截止时间',
  `is_buy` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否购买(0未购买 1已购买)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '任务状态 (0已结束 1砍价中)',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='砍价任务表';

/*Table structure for table `vic_bargain_task_help` */

DROP TABLE IF EXISTS `vic_bargain_task_help`;

CREATE TABLE `vic_bargain_task_help` (
  `help_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `active_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '砍价活动id',
  `task_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '砍价任务id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `is_creater` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为发起人(0否 1是)',
  `cut_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '砍掉的金额',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`help_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='砍价任务助力记录表';

/*Table structure for table `vic_category` */

DROP TABLE IF EXISTS `vic_category`;

CREATE TABLE `vic_category` (
  `category_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品分类id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '分类名称',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类id',
  `image_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分类图片id',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序方式(数字越小越靠前)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10070 DEFAULT CHARSET=utf8 COMMENT='商品分类表';

/*Table structure for table `vic_comment` */

DROP TABLE IF EXISTS `vic_comment`;

CREATE TABLE `vic_comment` (
  `comment_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '评价id',
  `score` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '评分 (10好评 20中评 30差评)',
  `content` text NOT NULL COMMENT '评价内容',
  `is_picture` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为图片评价',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '评价排序',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0隐藏 1显示)',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `order_goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单商品id',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `is_delete` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '软删除',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10003 DEFAULT CHARSET=utf8 COMMENT='订单评价记录表';

/*Table structure for table `vic_comment_image` */

DROP TABLE IF EXISTS `vic_comment_image`;

CREATE TABLE `vic_comment_image` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `comment_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评价id',
  `image_id` int(11) NOT NULL DEFAULT '0' COMMENT '图片id(关联文件记录表)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单评价图片记录表';

/*Table structure for table `vic_coupon` */

DROP TABLE IF EXISTS `vic_coupon`;

CREATE TABLE `vic_coupon` (
  `coupon_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '优惠券id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '优惠券名称',
  `color` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '优惠券颜色(10蓝 20红 30紫 40黄)',
  `coupon_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '优惠券类型(10满减券 20折扣券)',
  `reduce_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '满减券-减免金额',
  `discount` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '折扣券-折扣率(0-100)',
  `min_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '最低消费金额',
  `expire_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '到期类型(10领取后生效 20固定时间)',
  `expire_day` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '领取后生效-有效天数',
  `start_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '固定时间-开始时间',
  `end_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '固定时间-结束时间',
  `apply_range` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '适用范围(10全部商品 20指定商品)',
  `total_num` int(11) NOT NULL DEFAULT '0' COMMENT '发放总数量(-1为不限制)',
  `receive_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '已领取数量',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序方式(数字越小越靠前)',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '软删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`coupon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10002 DEFAULT CHARSET=utf8 COMMENT='优惠券记录表';

/*Table structure for table `vic_coupon_goods` */

DROP TABLE IF EXISTS `vic_coupon_goods`;

CREATE TABLE `vic_coupon_goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `coupon_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='优惠券指定商品记录表';

/*Table structure for table `vic_dealer_apply` */

DROP TABLE IF EXISTS `vic_dealer_apply`;

CREATE TABLE `vic_dealer_apply` (
  `apply_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `real_name` varchar(30) NOT NULL DEFAULT '' COMMENT '姓名',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号',
  `referee_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '推荐人用户id',
  `apply_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '申请方式(10需后台审核 20无需审核)',
  `apply_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '申请时间',
  `apply_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '审核状态 (10待审核 20审核通过 30驳回)',
  `audit_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '审核时间',
  `reject_reason` varchar(500) NOT NULL DEFAULT '' COMMENT '驳回原因',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`apply_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10015 DEFAULT CHARSET=utf8 COMMENT='分销商申请记录表';

/*Table structure for table `vic_dealer_capital` */

DROP TABLE IF EXISTS `vic_dealer_capital`;

CREATE TABLE `vic_dealer_capital` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分销商用户id',
  `flow_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '资金流动类型 (10佣金收入 20提现支出)',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `describe` varchar(500) NOT NULL DEFAULT '' COMMENT '描述',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10021 DEFAULT CHARSET=utf8 COMMENT='分销商资金明细表';

/*Table structure for table `vic_dealer_order` */

DROP TABLE IF EXISTS `vic_dealer_order`;

CREATE TABLE `vic_dealer_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id (买家)',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单id',
  `order_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '订单类型(10商城订单 20拼团订单)',
  `order_no` varchar(20) NOT NULL DEFAULT '' COMMENT '订单号(废弃,勿用)',
  `order_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单总金额(不含运费)',
  `first_user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分销商用户id(一级)',
  `second_user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分销商用户id(二级)',
  `third_user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分销商用户id(三级)',
  `first_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '分销佣金(一级)',
  `second_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '分销佣金(二级)',
  `third_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '分销佣金(三级)',
  `is_invalid` tinyint(3) NOT NULL DEFAULT '0' COMMENT '订单是否失效(0未失效 1已失效)',
  `is_settled` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否已结算佣金(0未结算 1已结算)',
  `settle_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '结算时间',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10043 DEFAULT CHARSET=utf8 COMMENT='分销商订单记录表';

/*Table structure for table `vic_dealer_referee` */

DROP TABLE IF EXISTS `vic_dealer_referee`;

CREATE TABLE `vic_dealer_referee` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `dealer_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分销商用户id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id(被推荐人)',
  `level` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '推荐关系层级(1,2,3)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `dealer_id` (`dealer_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10019 DEFAULT CHARSET=utf8 COMMENT='分销商推荐关系表';

/*Table structure for table `vic_dealer_setting` */

DROP TABLE IF EXISTS `vic_dealer_setting`;

CREATE TABLE `vic_dealer_setting` (
  `key` varchar(30) NOT NULL DEFAULT '' COMMENT '设置项标示',
  `describe` varchar(255) NOT NULL DEFAULT '' COMMENT '设置项描述',
  `values` mediumtext NOT NULL COMMENT '设置内容(json格式)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  UNIQUE KEY `unique_key` (`key`,`wxapp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分销商设置表';

/*Table structure for table `vic_dealer_user` */

DROP TABLE IF EXISTS `vic_dealer_user`;

CREATE TABLE `vic_dealer_user` (
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分销商用户id',
  `real_name` varchar(30) NOT NULL DEFAULT '' COMMENT '姓名',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号',
  `money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '当前可提现佣金',
  `freeze_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '已冻结佣金',
  `total_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '累积提现佣金',
  `referee_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '推荐人用户id',
  `first_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成员数量(一级)',
  `second_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成员数量(二级)',
  `third_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成员数量(三级)',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分销商用户记录表';

/*Table structure for table `vic_dealer_withdraw` */

DROP TABLE IF EXISTS `vic_dealer_withdraw`;

CREATE TABLE `vic_dealer_withdraw` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分销商用户id',
  `money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '提现金额',
  `pay_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '打款方式 (10微信 20支付宝 30银行卡)',
  `alipay_name` varchar(30) NOT NULL DEFAULT '' COMMENT '支付宝姓名',
  `alipay_account` varchar(30) NOT NULL DEFAULT '' COMMENT '支付宝账号',
  `bank_name` varchar(30) NOT NULL DEFAULT '' COMMENT '开户行名称',
  `bank_account` varchar(30) NOT NULL DEFAULT '' COMMENT '银行开户名',
  `bank_card` varchar(30) NOT NULL DEFAULT '' COMMENT '银行卡号',
  `apply_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '申请状态 (10待审核 20审核通过 30驳回 40已打款)',
  `audit_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '审核时间',
  `reject_reason` varchar(500) NOT NULL DEFAULT '' COMMENT '驳回原因',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10007 DEFAULT CHARSET=utf8 COMMENT='分销商提现明细表';

/*Table structure for table `vic_delivery` */

DROP TABLE IF EXISTS `vic_delivery`;

CREATE TABLE `vic_delivery` (
  `delivery_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '模板id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '模板名称',
  `method` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '计费方式(10按件数 20按重量)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序d',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序方式(数字越小越靠前)',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`delivery_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10006 DEFAULT CHARSET=utf8 COMMENT='配送模板主表';

/*Table structure for table `vic_delivery_rule` */

DROP TABLE IF EXISTS `vic_delivery_rule`;

CREATE TABLE `vic_delivery_rule` (
  `rule_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id',
  `delivery_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '配送模板id',
  `region` text NOT NULL COMMENT '可配送区域(城市id集)',
  `first` double unsigned NOT NULL DEFAULT '0' COMMENT '首件(个)/首重(Kg)',
  `first_fee` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '运费(元)',
  `additional` double unsigned NOT NULL DEFAULT '0' COMMENT '续件/续重',
  `additional_fee` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '续费(元)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`rule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10009 DEFAULT CHARSET=utf8 COMMENT='配送模板区域及运费表';

/*Table structure for table `vic_express` */

DROP TABLE IF EXISTS `vic_express`;

CREATE TABLE `vic_express` (
  `express_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '物流公司id',
  `express_name` varchar(255) NOT NULL DEFAULT '' COMMENT '物流公司名称',
  `express_code` varchar(30) NOT NULL DEFAULT '' COMMENT '物流公司代码 (快递100)',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序 (数字越小越靠前)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`express_id`),
  KEY `express_code` (`express_code`)
) ENGINE=InnoDB AUTO_INCREMENT=10010 DEFAULT CHARSET=utf8 COMMENT='物流公司记录表';

/*Table structure for table `vic_goods` */

DROP TABLE IF EXISTS `vic_goods`;

CREATE TABLE `vic_goods` (
  `goods_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `goods_name` varchar(255) NOT NULL DEFAULT '' COMMENT '商品名称',
  `selling_point` varchar(500) NOT NULL DEFAULT '' COMMENT '商品卖点',
  `category_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品分类id',
  `spec_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '商品规格(10单规格 20多规格)',
  `deduct_stock_type` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '库存计算方式(10下单减库存 20付款减库存)',
  `content` longtext NOT NULL COMMENT '商品详情',
  `sales_initial` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '初始销量',
  `sales_actual` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '实际销量',
  `goods_sort` int(11) unsigned NOT NULL DEFAULT '100' COMMENT '商品排序(数字越小越靠前)',
  `delivery_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '配送模板id',
  `is_points_gift` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否开启积分赠送(1开启 0关闭)',
  `is_points_discount` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否允许使用积分抵扣(1允许 0不允许)',
  `points_discount_ratio` tinyint(3) NOT NULL DEFAULT '0' COMMENT '可抵扣金额（比例0~100）',
  `is_enable_grade` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否开启会员折扣(1开启 0关闭)',
  `is_alone_grade` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '会员折扣设置(0默认等级折扣 1单独设置折扣)',
  `alone_grade_equity` text COMMENT '单独设置折扣的配置',
  `is_ind_dealer` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否开启单独分销(0关闭 1开启)',
  `dealer_money_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '分销佣金类型(10百分比 20固定金额)',
  `first_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '分销佣金(一级)',
  `second_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '分销佣金(二级)',
  `third_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '分销佣金(三级)',
  `goods_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '商品状态(10上架 20下架)',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`goods_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10375 DEFAULT CHARSET=utf8 COMMENT='商品记录表';

/*Table structure for table `vic_goods_image` */

DROP TABLE IF EXISTS `vic_goods_image`;

CREATE TABLE `vic_goods_image` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `image_id` int(11) NOT NULL COMMENT '图片id(关联文件记录表)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15924 DEFAULT CHARSET=utf8 COMMENT='商品图片记录表';

/*Table structure for table `vic_goods_sku` */

DROP TABLE IF EXISTS `vic_goods_sku`;

CREATE TABLE `vic_goods_sku` (
  `goods_sku_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品规格id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `spec_sku_id` varchar(255) NOT NULL DEFAULT '0' COMMENT '商品sku记录索引 (由规格id组成)',
  `image_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '规格图片id',
  `goods_no` varchar(100) NOT NULL DEFAULT '' COMMENT '商品编码',
  `goods_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品价格',
  `line_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品划线价',
  `stock_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当前库存数量',
  `goods_sales` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品销量',
  `goods_weight` double unsigned NOT NULL DEFAULT '0' COMMENT '商品重量(Kg)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`goods_sku_id`),
  UNIQUE KEY `sku_idx` (`goods_id`,`spec_sku_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11010 DEFAULT CHARSET=utf8 COMMENT='商品规格表';

/*Table structure for table `vic_goods_spec_rel` */

DROP TABLE IF EXISTS `vic_goods_spec_rel`;

CREATE TABLE `vic_goods_spec_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `spec_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '规格组id',
  `spec_value_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '规格值id',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='商品与规格值关系记录表';

/*Table structure for table `vic_order` */

DROP TABLE IF EXISTS `vic_order`;

CREATE TABLE `vic_order` (
  `order_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `order_no` varchar(20) NOT NULL DEFAULT '' COMMENT '订单号',
  `total_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品总金额(不含优惠折扣)',
  `order_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单金额(含优惠折扣)',
  `coupon_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券id',
  `coupon_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '优惠券抵扣金额',
  `points_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '积分抵扣金额',
  `points_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '积分抵扣数量',
  `pay_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '实际付款金额(包含运费)',
  `update_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '后台修改的订单金额（差价）',
  `buyer_remark` varchar(255) NOT NULL DEFAULT '' COMMENT '买家留言',
  `pay_type` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '支付方式(10余额支付 20微信支付)',
  `pay_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '付款状态(10未付款 20已付款)',
  `pay_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '付款时间',
  `delivery_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '配送方式(10快递配送 20上门自提)',
  `extract_shop_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '自提门店id',
  `extract_clerk_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '核销店员id',
  `express_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '运费金额',
  `express_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '物流公司id',
  `express_company` varchar(50) NOT NULL DEFAULT '' COMMENT '物流公司',
  `express_no` varchar(50) NOT NULL DEFAULT '' COMMENT '物流单号',
  `delivery_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '发货状态(10未发货 20已发货)',
  `delivery_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '发货时间',
  `receipt_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '收货状态(10未收货 20已收货)',
  `receipt_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '收货时间',
  `order_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '订单状态(10进行中 20取消 21待取消 30已完成)',
  `points_bonus` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '赠送的积分数量',
  `is_settled` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单是否已结算(0未结算 1已结算)',
  `transaction_id` varchar(30) NOT NULL DEFAULT '' COMMENT '微信支付交易号',
  `is_comment` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '是否已评价(0否 1是)',
  `order_source` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '订单来源(10普通订单 20砍价订单)',
  `source_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '来源记录id',
  `order_source_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '来源记录id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10089 DEFAULT CHARSET=utf8 COMMENT='订单记录表';

/*Table structure for table `vic_order_address` */

DROP TABLE IF EXISTS `vic_order_address`;

CREATE TABLE `vic_order_address` (
  `order_address_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '地址id',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '联系电话',
  `province_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所在省份id',
  `city_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所在城市id',
  `region_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所在区id',
  `detail` varchar(255) NOT NULL DEFAULT '' COMMENT '详细地址',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`order_address_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10089 DEFAULT CHARSET=utf8 COMMENT='订单收货地址记录表';

/*Table structure for table `vic_order_extract` */

DROP TABLE IF EXISTS `vic_order_extract`;

CREATE TABLE `vic_order_extract` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单id',
  `linkman` varchar(30) NOT NULL DEFAULT '' COMMENT '联系人姓名',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '联系电话',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自提订单联系方式记录表';

/*Table structure for table `vic_order_goods` */

DROP TABLE IF EXISTS `vic_order_goods`;

CREATE TABLE `vic_order_goods` (
  `order_goods_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `goods_name` varchar(255) NOT NULL DEFAULT '' COMMENT '商品名称',
  `image_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品封面图id',
  `deduct_stock_type` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '库存计算方式(10下单减库存 20付款减库存)',
  `spec_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '规格类型(10单规格 20多规格)',
  `spec_sku_id` varchar(255) NOT NULL DEFAULT '' COMMENT '商品sku标识',
  `goods_sku_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品规格id',
  `goods_attr` varchar(500) NOT NULL DEFAULT '' COMMENT '商品规格信息',
  `content` longtext NOT NULL COMMENT '商品详情',
  `goods_no` varchar(100) NOT NULL DEFAULT '' COMMENT '商品编码',
  `goods_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品价格(单价)',
  `line_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品划线价',
  `goods_weight` double unsigned NOT NULL DEFAULT '0' COMMENT '商品重量(Kg)',
  `is_user_grade` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否存在会员等级折扣',
  `grade_ratio` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '会员折扣比例(0-10)',
  `grade_goods_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '会员折扣的商品单价',
  `grade_total_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '会员折扣的总额差',
  `coupon_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '优惠券折扣金额',
  `points_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '积分金额',
  `points_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '积分抵扣数量',
  `points_bonus` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '赠送的积分数量',
  `total_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '购买数量',
  `total_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品总价(数量×单价)',
  `total_pay_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '实际付款价(折扣和优惠后)',
  `is_ind_dealer` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否开启单独分销(0关闭 1开启)',
  `dealer_money_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '分销佣金类型(10百分比 20固定金额)',
  `first_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '分销佣金(一级)',
  `second_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '分销佣金(二级)',
  `third_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '分销佣金(三级)',
  `is_comment` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '是否已评价(0否 1是)',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`order_goods_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10098 DEFAULT CHARSET=utf8 COMMENT='订单商品记录表';

/*Table structure for table `vic_order_refund` */

DROP TABLE IF EXISTS `vic_order_refund`;

CREATE TABLE `vic_order_refund` (
  `order_refund_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '售后单id',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单id',
  `order_goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单商品id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '售后类型(10退货退款 20换货)',
  `apply_desc` varchar(1000) NOT NULL DEFAULT '' COMMENT '用户申请原因(说明)',
  `is_agree` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '商家审核状态(0待审核 10已同意 20已拒绝)',
  `refuse_desc` varchar(1000) NOT NULL DEFAULT '' COMMENT '商家拒绝原因(说明)',
  `refund_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '实际退款金额',
  `is_user_send` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '用户是否发货(0未发货 1已发货)',
  `send_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户发货时间',
  `express_id` varchar(32) NOT NULL DEFAULT '' COMMENT '用户发货物流公司id',
  `express_no` varchar(32) NOT NULL DEFAULT '' COMMENT '用户发货物流单号',
  `is_receipt` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '商家收货状态(0未收货 1已收货)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '售后单状态(0进行中 10已拒绝 20已完成 30已取消)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`order_refund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='售后单记录表';

/*Table structure for table `vic_order_refund_address` */

DROP TABLE IF EXISTS `vic_order_refund_address`;

CREATE TABLE `vic_order_refund_address` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `order_refund_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '售后单id',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '联系电话',
  `detail` varchar(255) NOT NULL DEFAULT '' COMMENT '详细地址',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='售后单退货地址记录表';

/*Table structure for table `vic_order_refund_image` */

DROP TABLE IF EXISTS `vic_order_refund_image`;

CREATE TABLE `vic_order_refund_image` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `order_refund_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '售后单id',
  `image_id` int(11) NOT NULL DEFAULT '0' COMMENT '图片id(关联文件记录表)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='售后单图片记录表';

/*Table structure for table `vic_printer` */

DROP TABLE IF EXISTS `vic_printer`;

CREATE TABLE `vic_printer` (
  `printer_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '打印机id',
  `printer_name` varchar(255) NOT NULL DEFAULT '' COMMENT '打印机名称',
  `printer_type` varchar(255) NOT NULL DEFAULT '' COMMENT '打印机类型',
  `printer_config` text NOT NULL COMMENT '打印机配置',
  `print_times` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '打印联数(次数)',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序 (数字越小越靠前)',
  `is_delete` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`printer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='小票打印机记录表';

/*Table structure for table `vic_recharge_order` */

DROP TABLE IF EXISTS `vic_recharge_order`;

CREATE TABLE `vic_recharge_order` (
  `order_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `order_no` varchar(20) NOT NULL DEFAULT '' COMMENT '订单号',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `recharge_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '充值方式(10自定义金额 20套餐充值)',
  `plan_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '充值套餐id',
  `pay_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '用户支付金额',
  `gift_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '赠送金额',
  `actual_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '实际到账金额',
  `pay_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '支付状态(10待支付 20已支付)',
  `pay_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '付款时间',
  `transaction_id` varchar(30) NOT NULL DEFAULT '' COMMENT '微信支付交易号',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序商城id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10031 DEFAULT CHARSET=utf8 COMMENT='用户充值订单表';

/*Table structure for table `vic_recharge_order_plan` */

DROP TABLE IF EXISTS `vic_recharge_order_plan`;

CREATE TABLE `vic_recharge_order_plan` (
  `order_plan_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单id',
  `plan_id` int(11) unsigned NOT NULL COMMENT '主键id',
  `plan_name` varchar(255) NOT NULL DEFAULT '' COMMENT '方案名称',
  `money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '充值金额',
  `gift_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '赠送金额',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序商城id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`order_plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户充值订单套餐快照表';

/*Table structure for table `vic_recharge_plan` */

DROP TABLE IF EXISTS `vic_recharge_plan`;

CREATE TABLE `vic_recharge_plan` (
  `plan_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `plan_name` varchar(255) NOT NULL DEFAULT '' COMMENT '套餐名称',
  `money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '充值金额',
  `gift_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '赠送金额',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序(数字越小越靠前)',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序商城id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='余额充值套餐表';

/*Table structure for table `vic_region` */

DROP TABLE IF EXISTS `vic_region`;

CREATE TABLE `vic_region` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(11) DEFAULT NULL COMMENT '父id',
  `shortname` varchar(100) DEFAULT NULL COMMENT '简称',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `merger_name` varchar(255) DEFAULT NULL COMMENT '全称',
  `level` tinyint(4) unsigned DEFAULT '0' COMMENT '层级 1 2 3 省市区县',
  `pinyin` varchar(100) DEFAULT NULL COMMENT '拼音',
  `code` varchar(100) DEFAULT NULL COMMENT '长途区号',
  `zip_code` varchar(100) DEFAULT NULL COMMENT '邮编',
  `first` varchar(50) DEFAULT NULL COMMENT '首字母',
  `lng` varchar(100) DEFAULT NULL COMMENT '经度',
  `lat` varchar(100) DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`),
  KEY `name,level` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4018 DEFAULT CHARSET=utf8;

/*Table structure for table `vic_return_address` */

DROP TABLE IF EXISTS `vic_return_address`;

CREATE TABLE `vic_return_address` (
  `address_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '退货地址id',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '联系电话',
  `detail` varchar(255) NOT NULL DEFAULT '' COMMENT '详细地址',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序 (数字越小越靠前)',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退货地址记录表';

/*Table structure for table `vic_setting` */

DROP TABLE IF EXISTS `vic_setting`;

CREATE TABLE `vic_setting` (
  `key` varchar(30) NOT NULL COMMENT '设置项标示',
  `describe` varchar(255) NOT NULL DEFAULT '' COMMENT '设置项描述',
  `values` mediumtext NOT NULL COMMENT '设置内容（json格式）',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  UNIQUE KEY `unique_key` (`key`,`wxapp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商城设置记录表';

/*Table structure for table `vic_sharing_active` */

DROP TABLE IF EXISTS `vic_sharing_active`;

CREATE TABLE `vic_sharing_active` (
  `active_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '拼单id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '拼团商品id',
  `people` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成团人数',
  `actual_people` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当前已拼人数',
  `creator_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '团长用户id',
  `end_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '拼单结束时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '拼单状态(0未拼单 10拼单中 20拼单成功 30拼单失败)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`active_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼团拼单记录表';

/*Table structure for table `vic_sharing_active_users` */

DROP TABLE IF EXISTS `vic_sharing_active_users`;

CREATE TABLE `vic_sharing_active_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `active_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '拼单id',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '拼团订单id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `is_creator` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为创建者',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼团拼单成员记录表';

/*Table structure for table `vic_sharing_category` */

DROP TABLE IF EXISTS `vic_sharing_category`;

CREATE TABLE `vic_sharing_category` (
  `category_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品分类id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '分类名称',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类id',
  `image_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分类图片id',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序方式(数字越小越靠前)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼团商品分类表';

/*Table structure for table `vic_sharing_comment` */

DROP TABLE IF EXISTS `vic_sharing_comment`;

CREATE TABLE `vic_sharing_comment` (
  `comment_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '评价id',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '拼团订单id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '拼团商品id',
  `order_goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单商品id',
  `score` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '评分(10好评 20中评 30差评)',
  `content` text NOT NULL COMMENT '评价内容',
  `is_picture` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为图片评价',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '评价排序',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0隐藏 1显示)',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `is_delete` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '软删除',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼团商品评价表';

/*Table structure for table `vic_sharing_comment_image` */

DROP TABLE IF EXISTS `vic_sharing_comment_image`;

CREATE TABLE `vic_sharing_comment_image` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `comment_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评价id',
  `image_id` int(11) NOT NULL DEFAULT '0' COMMENT '图片id(关联文件记录表)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼团评价图片记录表';

/*Table structure for table `vic_sharing_goods` */

DROP TABLE IF EXISTS `vic_sharing_goods`;

CREATE TABLE `vic_sharing_goods` (
  `goods_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '拼团商品id',
  `goods_name` varchar(255) NOT NULL DEFAULT '' COMMENT '商品名称',
  `category_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品分类id',
  `selling_point` varchar(500) NOT NULL DEFAULT '' COMMENT '商品卖点',
  `people` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '成团人数',
  `group_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成团有效时间(单位:小时)',
  `is_alone` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许单买(0不允许 1允许)',
  `spec_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '商品规格(10单规格 20多规格)',
  `deduct_stock_type` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '库存计算方式(10下单减库存 20付款减库存)',
  `content` longtext NOT NULL COMMENT '商品详情',
  `sales_initial` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '初始销量',
  `sales_actual` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '实际销量',
  `goods_sort` int(11) unsigned NOT NULL DEFAULT '100' COMMENT '商品排序(数字越小越靠前)',
  `delivery_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '配送模板id',
  `is_points_gift` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否开启积分赠送(1开启 0关闭)',
  `is_points_discount` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否允许使用积分抵扣(1允许 0不允许)',
  `is_enable_grade` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否开启会员折扣(1开启 0关闭)',
  `is_alone_grade` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '会员折扣设置(0默认等级折扣 1单独设置折扣)',
  `alone_grade_equity` text COMMENT '单独设置折扣的配置',
  `is_ind_dealer` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否开启单独分销(0关闭 1开启)',
  `dealer_money_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '分销佣金类型(10百分比 20固定金额)',
  `first_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '分销佣金(一级)',
  `second_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '分销佣金(二级)',
  `third_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '分销佣金(三级)',
  `goods_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '商品状态(10上架 20下架)',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`goods_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼团商品记录表';

/*Table structure for table `vic_sharing_goods_image` */

DROP TABLE IF EXISTS `vic_sharing_goods_image`;

CREATE TABLE `vic_sharing_goods_image` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `image_id` int(11) NOT NULL COMMENT '图片id(关联文件记录表)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品图片记录表';

/*Table structure for table `vic_sharing_goods_sku` */

DROP TABLE IF EXISTS `vic_sharing_goods_sku`;

CREATE TABLE `vic_sharing_goods_sku` (
  `goods_sku_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品规格id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `spec_sku_id` varchar(255) NOT NULL DEFAULT '0' COMMENT '商品sku记录索引(由规格id组成)',
  `image_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '规格图片id',
  `goods_no` varchar(100) NOT NULL DEFAULT '' COMMENT '商品编码',
  `sharing_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '拼团价格',
  `goods_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品价格(单买价)',
  `line_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品划线价',
  `stock_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当前库存数量',
  `goods_sales` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品销量',
  `goods_weight` double unsigned NOT NULL DEFAULT '0' COMMENT '商品重量(Kg)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`goods_sku_id`),
  UNIQUE KEY `sku_idx` (`goods_id`,`spec_sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼团商品规格表';

/*Table structure for table `vic_sharing_goods_spec_rel` */

DROP TABLE IF EXISTS `vic_sharing_goods_spec_rel`;

CREATE TABLE `vic_sharing_goods_spec_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `spec_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '规格组id',
  `spec_value_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '规格值id',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼团商品与规格值关系记录表';

/*Table structure for table `vic_sharing_order` */

DROP TABLE IF EXISTS `vic_sharing_order`;

CREATE TABLE `vic_sharing_order` (
  `order_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `order_no` varchar(20) NOT NULL DEFAULT '' COMMENT '订单号',
  `total_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品总金额(不含优惠折扣)',
  `order_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单金额(含优惠折扣)',
  `order_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单类型(10单独购买 20拼团)',
  `active_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '拼单id',
  `coupon_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券id',
  `coupon_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '优惠券抵扣金额',
  `points_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '积分抵扣金额',
  `points_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '积分抵扣数量',
  `pay_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '实际付款金额(包含运费、优惠)',
  `update_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '后台修改的订单金额（差价）',
  `buyer_remark` varchar(255) NOT NULL DEFAULT '' COMMENT '买家留言',
  `pay_type` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '支付方式(10余额支付 20微信支付)',
  `pay_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '付款状态(10未付款 20已付款)',
  `pay_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '付款时间',
  `delivery_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '配送方式(10快递配送 20上门自提)',
  `extract_shop_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '自提门店id',
  `extract_clerk_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '核销店员id',
  `express_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '运费金额',
  `express_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '物流公司id',
  `express_company` varchar(50) NOT NULL DEFAULT '' COMMENT '物流公司',
  `express_no` varchar(50) NOT NULL DEFAULT '' COMMENT '物流单号',
  `delivery_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '发货状态(10未发货 20已发货)',
  `delivery_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '发货时间',
  `receipt_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '收货状态(10未收货 20已收货)',
  `receipt_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '收货时间',
  `order_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '订单状态(10进行中 20已取消 21待取消 30已完成)',
  `points_bonus` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '赠送的积分数量',
  `is_settled` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单是否已结算(0未结算 1已结算)',
  `is_refund` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '拼团未成功退款(0未退款 1已退款)',
  `transaction_id` varchar(30) NOT NULL DEFAULT '' COMMENT '微信支付交易号',
  `is_comment` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '是否已评价(0否 1是)',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单记录表';

/*Table structure for table `vic_sharing_order_address` */

DROP TABLE IF EXISTS `vic_sharing_order_address`;

CREATE TABLE `vic_sharing_order_address` (
  `order_address_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '地址id',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '联系电话',
  `province_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所在省份id',
  `city_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所在城市id',
  `region_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所在区id',
  `detail` varchar(255) NOT NULL DEFAULT '' COMMENT '详细地址',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '拼团订单id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`order_address_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼团订单收货地址记录表';

/*Table structure for table `vic_sharing_order_extract` */

DROP TABLE IF EXISTS `vic_sharing_order_extract`;

CREATE TABLE `vic_sharing_order_extract` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单id',
  `linkman` varchar(30) NOT NULL DEFAULT '' COMMENT '联系人姓名',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '联系电话',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自提订单联系方式记录表';

/*Table structure for table `vic_sharing_order_goods` */

DROP TABLE IF EXISTS `vic_sharing_order_goods`;

CREATE TABLE `vic_sharing_order_goods` (
  `order_goods_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '拼团商品id',
  `goods_name` varchar(255) NOT NULL DEFAULT '' COMMENT '商品名称',
  `image_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品封面图id',
  `selling_point` varchar(500) NOT NULL DEFAULT '' COMMENT '商品卖点',
  `people` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '成团人数',
  `group_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成团有效时间(单位:小时)',
  `is_alone` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许单买(0不允许 1允许)',
  `deduct_stock_type` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '库存计算方式(10下单减库存 20付款减库存)',
  `spec_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '规格类型(10单规格 20多规格)',
  `spec_sku_id` varchar(255) NOT NULL DEFAULT '' COMMENT '商品sku标识',
  `goods_sku_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品规格id',
  `goods_attr` varchar(500) NOT NULL DEFAULT '' COMMENT '商品规格信息',
  `content` longtext NOT NULL COMMENT '商品详情',
  `goods_no` varchar(100) NOT NULL DEFAULT '' COMMENT '商品编码',
  `goods_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品价格(单价)',
  `line_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品划线价',
  `goods_weight` double unsigned NOT NULL DEFAULT '0' COMMENT '商品重量(Kg)',
  `is_user_grade` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否存在会员等级折扣',
  `grade_ratio` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '会员折扣比例(0-10)',
  `grade_goods_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '会员折扣的商品单价',
  `grade_total_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '会员折扣的总额差',
  `coupon_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '优惠券折扣金额',
  `points_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '积分金额',
  `points_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '积分抵扣数量',
  `points_bonus` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '赠送的积分数量',
  `total_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '购买数量',
  `total_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品总价(数量×单价)',
  `total_pay_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '实际付款价(包含优惠、折扣)',
  `is_ind_dealer` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否开启单独分销(0关闭 1开启)',
  `dealer_money_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '分销佣金类型(10百分比 20固定金额)',
  `first_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '分销佣金(一级)',
  `second_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '分销佣金(二级)',
  `third_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '分销佣金(三级)',
  `is_comment` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '是否已评价(0否 1是)',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '拼团订单id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`order_goods_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单商品记录表';

/*Table structure for table `vic_sharing_order_refund` */

DROP TABLE IF EXISTS `vic_sharing_order_refund`;

CREATE TABLE `vic_sharing_order_refund` (
  `order_refund_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '售后单id',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '拼团订单id',
  `order_goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单商品id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '售后类型(10退货退款 20换货)',
  `apply_desc` varchar(1000) NOT NULL DEFAULT '' COMMENT '用户申请原因(说明)',
  `is_agree` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '商家审核状态(0待审核 10已同意 20已拒绝)',
  `refuse_desc` varchar(1000) NOT NULL DEFAULT '' COMMENT '商家拒绝原因(说明)',
  `refund_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '实际退款金额',
  `is_user_send` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '用户是否发货(0未发货 1已发货)',
  `send_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户发货时间',
  `express_id` varchar(32) NOT NULL DEFAULT '' COMMENT '用户发货物流公司id',
  `express_no` varchar(32) NOT NULL DEFAULT '' COMMENT '用户发货物流单号',
  `is_receipt` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '商家收货状态(0未收货 1已收货)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '售后单状态(0进行中 10已拒绝 20已完成 30已取消)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`order_refund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼团售后单记录表';

/*Table structure for table `vic_sharing_order_refund_address` */

DROP TABLE IF EXISTS `vic_sharing_order_refund_address`;

CREATE TABLE `vic_sharing_order_refund_address` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `order_refund_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '售后单id',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '联系电话',
  `detail` varchar(255) NOT NULL DEFAULT '' COMMENT '详细地址',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼团售后单退货地址记录表';

/*Table structure for table `vic_sharing_order_refund_image` */

DROP TABLE IF EXISTS `vic_sharing_order_refund_image`;

CREATE TABLE `vic_sharing_order_refund_image` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `order_refund_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '售后单id',
  `image_id` int(11) NOT NULL DEFAULT '0' COMMENT '图片id(关联文件记录表)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼团售后单图片记录表';

/*Table structure for table `vic_sharing_setting` */

DROP TABLE IF EXISTS `vic_sharing_setting`;

CREATE TABLE `vic_sharing_setting` (
  `key` varchar(30) NOT NULL DEFAULT '' COMMENT '设置项标示',
  `describe` varchar(255) NOT NULL DEFAULT '' COMMENT '设置项描述',
  `values` mediumtext NOT NULL COMMENT '设置内容(json格式)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  UNIQUE KEY `unique_key` (`key`,`wxapp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼团设置表';

/*Table structure for table `vic_spec` */

DROP TABLE IF EXISTS `vic_spec`;

CREATE TABLE `vic_spec` (
  `spec_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '规格组id',
  `spec_name` varchar(255) NOT NULL DEFAULT '' COMMENT '规格组名称',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`spec_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='商品规格组记录表';

/*Table structure for table `vic_spec_value` */

DROP TABLE IF EXISTS `vic_spec_value`;

CREATE TABLE `vic_spec_value` (
  `spec_value_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '规格值id',
  `spec_value` varchar(255) NOT NULL COMMENT '规格值',
  `spec_id` int(11) NOT NULL COMMENT '规格组id',
  `wxapp_id` int(11) NOT NULL COMMENT '小程序id',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`spec_value_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='商品规格值记录表';

/*Table structure for table `vic_store_access` */

DROP TABLE IF EXISTS `vic_store_access`;

CREATE TABLE `vic_store_access` (
  `access_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '权限名称',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '权限url',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '100' COMMENT '排序(数字越小越靠前)',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`access_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10444 DEFAULT CHARSET=utf8 COMMENT='商家用户权限表';

/*Table structure for table `vic_store_role` */

DROP TABLE IF EXISTS `vic_store_role`;

CREATE TABLE `vic_store_role` (
  `role_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role_name` varchar(50) NOT NULL DEFAULT '' COMMENT '角色名称',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父级角色id',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '100' COMMENT '排序(数字越小越靠前)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10005 DEFAULT CHARSET=utf8 COMMENT='商家用户角色表';

/*Table structure for table `vic_store_role_access` */

DROP TABLE IF EXISTS `vic_store_role_access`;

CREATE TABLE `vic_store_role_access` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `role_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '角色id',
  `access_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '权限id',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10295 DEFAULT CHARSET=utf8 COMMENT='商家用户角色权限关系表';

/*Table structure for table `vic_store_shop` */

DROP TABLE IF EXISTS `vic_store_shop`;

CREATE TABLE `vic_store_shop` (
  `shop_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '门店id',
  `shop_name` varchar(255) NOT NULL DEFAULT '' COMMENT '门店名称',
  `logo_image_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '门店logo图片id',
  `linkman` varchar(20) NOT NULL DEFAULT '' COMMENT '联系人',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '联系电话',
  `shop_hours` varchar(255) NOT NULL DEFAULT '' COMMENT '营业时间',
  `province_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所在省份id',
  `city_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所在城市id',
  `region_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所在辖区id',
  `address` varchar(100) NOT NULL DEFAULT '' COMMENT '详细地址',
  `longitude` varchar(50) NOT NULL DEFAULT '' COMMENT '门店坐标经度',
  `latitude` varchar(50) NOT NULL DEFAULT '' COMMENT '门店坐标纬度',
  `geohash` varchar(50) NOT NULL DEFAULT '' COMMENT 'geohash',
  `summary` varchar(1000) NOT NULL DEFAULT '0' COMMENT '门店简介',
  `sort` tinyint(3) NOT NULL DEFAULT '0' COMMENT '门店排序(数字越小越靠前)',
  `is_check` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否支持自提核销(0否 1支持)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '门店状态(0禁用 1启用)',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家门店记录表';

/*Table structure for table `vic_store_shop_clerk` */

DROP TABLE IF EXISTS `vic_store_shop_clerk`;

CREATE TABLE `vic_store_shop_clerk` (
  `clerk_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '店员id',
  `shop_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属门店id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `real_name` varchar(30) NOT NULL DEFAULT '' COMMENT '店员姓名',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0禁用 1启用)',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`clerk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家门店店员表';

/*Table structure for table `vic_store_shop_order` */

DROP TABLE IF EXISTS `vic_store_shop_order`;

CREATE TABLE `vic_store_shop_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单id',
  `order_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '订单类型(10商城订单 20拼团订单)',
  `shop_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '门店id',
  `clerk_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '核销员id',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家门店核销订单记录表';

/*Table structure for table `vic_store_user` */

DROP TABLE IF EXISTS `vic_store_user`;

CREATE TABLE `vic_store_user` (
  `store_user_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_name` varchar(255) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(255) NOT NULL DEFAULT '' COMMENT '登录密码',
  `real_name` varchar(255) NOT NULL DEFAULT '' COMMENT '姓名',
  `is_super` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否为超级管理员',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`store_user_id`),
  KEY `user_name` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=10002 DEFAULT CHARSET=utf8 COMMENT='商家用户记录表';

/*Table structure for table `vic_store_user_role` */

DROP TABLE IF EXISTS `vic_store_user_role`;

CREATE TABLE `vic_store_user_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `store_user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '超管用户id',
  `role_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '角色id',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `admin_user_id` (`store_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家用户角色记录表';

/*Table structure for table `vic_upload_file` */

DROP TABLE IF EXISTS `vic_upload_file`;

CREATE TABLE `vic_upload_file` (
  `file_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件id',
  `storage` varchar(20) NOT NULL DEFAULT '' COMMENT '存储方式',
  `group_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '文件分组id',
  `file_url` varchar(255) NOT NULL DEFAULT '' COMMENT '存储域名',
  `file_name` varchar(255) NOT NULL DEFAULT '' COMMENT '文件路径',
  `file_size` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小(字节)',
  `file_type` varchar(20) NOT NULL DEFAULT '' COMMENT '文件类型',
  `extension` varchar(20) NOT NULL DEFAULT '' COMMENT '文件扩展名',
  `is_user` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '是否为c端用户上传',
  `is_recycle` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否已回收',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '软删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`file_id`),
  UNIQUE KEY `path_idx` (`file_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13391 DEFAULT CHARSET=utf8 COMMENT='文件库记录表';

/*Table structure for table `vic_upload_group` */

DROP TABLE IF EXISTS `vic_upload_group`;

CREATE TABLE `vic_upload_group` (
  `group_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `group_type` varchar(10) NOT NULL DEFAULT '' COMMENT '文件类型',
  `group_name` varchar(30) NOT NULL DEFAULT '' COMMENT '分类名称',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分类排序(数字越小越靠前)',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`group_id`),
  KEY `type_index` (`group_type`)
) ENGINE=InnoDB AUTO_INCREMENT=10113 DEFAULT CHARSET=utf8 COMMENT='文件库分组记录表';

/*Table structure for table `vic_user` */

DROP TABLE IF EXISTS `vic_user`;

CREATE TABLE `vic_user` (
  `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `open_id` varchar(255) NOT NULL DEFAULT '' COMMENT '微信openid(唯一标示)',
  `nickName` varchar(255) NOT NULL DEFAULT '' COMMENT '微信昵称',
  `avatarUrl` varchar(255) NOT NULL DEFAULT '' COMMENT '微信头像',
  `gender` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `country` varchar(50) NOT NULL DEFAULT '' COMMENT '国家',
  `province` varchar(50) NOT NULL DEFAULT '' COMMENT '省份',
  `city` varchar(50) NOT NULL DEFAULT '' COMMENT '城市',
  `address_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '默认收货地址',
  `balance` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '用户可用余额',
  `points` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户可用积分',
  `sign_day` tinyint(5) unsigned NOT NULL COMMENT '连续签到天数',
  `last_sign_time` int(11) NOT NULL COMMENT '最新签到时间',
  `pay_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '用户总支付的金额',
  `expend_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '实际消费的金额(不含退款)',
  `grade_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '会员等级id',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`user_id`),
  KEY `openid` (`open_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10063 DEFAULT CHARSET=utf8 COMMENT='用户记录表';

/*Table structure for table `vic_user_address` */

DROP TABLE IF EXISTS `vic_user_address`;

CREATE TABLE `vic_user_address` (
  `address_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '联系电话',
  `province_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所在省份id',
  `city_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所在城市id',
  `region_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所在区id',
  `district` varchar(255) DEFAULT '' COMMENT '新市辖区(该字段用于记录region表中没有的市辖区)',
  `detail` varchar(255) NOT NULL DEFAULT '' COMMENT '详细地址',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10035 DEFAULT CHARSET=utf8 COMMENT='用户收货地址表';

/*Table structure for table `vic_user_balance_log` */

DROP TABLE IF EXISTS `vic_user_balance_log`;

CREATE TABLE `vic_user_balance_log` (
  `log_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `scene` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '余额变动场景(10用户充值 20用户消费 30管理员操作 40订单退款 50分销商积分兑换)',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变动金额',
  `describe` varchar(500) NOT NULL DEFAULT '' COMMENT '描述/说明',
  `remark` varchar(500) NOT NULL DEFAULT '' COMMENT '管理员备注',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序商城id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10077 DEFAULT CHARSET=utf8 COMMENT='用户余额变动明细表';

/*Table structure for table `vic_user_coupon` */

DROP TABLE IF EXISTS `vic_user_coupon`;

CREATE TABLE `vic_user_coupon` (
  `user_coupon_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `coupon_id` int(11) unsigned NOT NULL COMMENT '优惠券id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '优惠券名称',
  `color` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '优惠券颜色(10蓝 20红 30紫 40黄)',
  `coupon_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '优惠券类型(10满减券 20折扣券)',
  `reduce_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '满减券-减免金额',
  `discount` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '折扣券-折扣率(0-100)',
  `min_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '最低消费金额',
  `expire_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '到期类型(10领取后生效 20固定时间)',
  `expire_day` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '领取后生效-有效天数',
  `start_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '有效期开始时间',
  `end_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '有效期结束时间',
  `apply_range` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '适用范围(10全部商品 20指定商品)',
  `is_expire` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否过期(0未过期 1已过期)',
  `is_use` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否已使用(0未使用 1已使用)',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`user_coupon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10004 DEFAULT CHARSET=utf8 COMMENT='用户优惠券记录表';

/*Table structure for table `vic_user_grade` */

DROP TABLE IF EXISTS `vic_user_grade`;

CREATE TABLE `vic_user_grade` (
  `grade_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '等级ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '等级名称',
  `weight` int(11) unsigned NOT NULL DEFAULT '1' COMMENT '等级权重(1-9999)',
  `upgrade` text NOT NULL COMMENT '升级条件',
  `equity` text NOT NULL COMMENT '等级权益(折扣率0-100)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态(1启用 0禁用)',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`grade_id`),
  KEY `wxapp_id` (`wxapp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10002 DEFAULT CHARSET=utf8 COMMENT='用户会员等级表';

/*Table structure for table `vic_user_grade_log` */

DROP TABLE IF EXISTS `vic_user_grade_log`;

CREATE TABLE `vic_user_grade_log` (
  `log_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `old_grade_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '变更前的等级id',
  `new_grade_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '变更后的等级id',
  `change_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '变更类型(10后台管理员设置 20自动升级)',
  `remark` varchar(500) DEFAULT '' COMMENT '管理员备注',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10008 DEFAULT CHARSET=utf8 COMMENT='用户会员等级变更记录表';

/*Table structure for table `vic_user_points_exchange` */

DROP TABLE IF EXISTS `vic_user_points_exchange`;

CREATE TABLE `vic_user_points_exchange` (
  `exchange_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `exchange_balance` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '兑换余额',
  `consume_points` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '消耗积分',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序商城id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`exchange_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10002 DEFAULT CHARSET=utf8 COMMENT='分销商积分兑换余额表';

/*Table structure for table `vic_user_points_log` */

DROP TABLE IF EXISTS `vic_user_points_log`;

CREATE TABLE `vic_user_points_log` (
  `log_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT '变动数量',
  `describe` varchar(500) NOT NULL DEFAULT '' COMMENT '描述/说明',
  `remark` varchar(500) NOT NULL DEFAULT '' COMMENT '管理员备注',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序商城id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10029 DEFAULT CHARSET=utf8 COMMENT='用户积分变动明细表';

/*Table structure for table `vic_user_sign_in` */

DROP TABLE IF EXISTS `vic_user_sign_in`;

CREATE TABLE `vic_user_sign_in` (
  `sign_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `sign_day` tinyint(5) NOT NULL COMMENT '连续签到天数',
  `get_points` tinyint(4) NOT NULL COMMENT '获得积分',
  `point_basic` tinyint(4) NOT NULL COMMENT '签到奖励',
  `point_bonus` tinyint(4) NOT NULL COMMENT '额外奖励',
  `wxapp_id` int(11) NOT NULL COMMENT '小程序商城id',
  `sign_time` int(11) NOT NULL COMMENT '签到时间',
  PRIMARY KEY (`sign_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10009 DEFAULT CHARSET=utf8 COMMENT='用户签到记录表';

/*Table structure for table `vic_wow_order` */

DROP TABLE IF EXISTS `vic_wow_order`;

CREATE TABLE `vic_wow_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单id',
  `order_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '订单类型(10商城订单 20拼团订单)',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态(3支付完成 4已发货 5已退款 100已完成)',
  `last_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10046 DEFAULT CHARSET=utf8 COMMENT='好物圈订单同步记录表';

/*Table structure for table `vic_wow_setting` */

DROP TABLE IF EXISTS `vic_wow_setting`;

CREATE TABLE `vic_wow_setting` (
  `key` varchar(30) NOT NULL DEFAULT '' COMMENT '设置项标示',
  `describe` varchar(255) NOT NULL DEFAULT '' COMMENT '设置项描述',
  `values` mediumtext NOT NULL COMMENT '设置内容(json格式)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  UNIQUE KEY `unique_key` (`key`,`wxapp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='好物圈设置表';

/*Table structure for table `vic_wow_shoping` */

DROP TABLE IF EXISTS `vic_wow_shoping`;

CREATE TABLE `vic_wow_shoping` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10018 DEFAULT CHARSET=utf8 COMMENT='好物圈商品收藏记录表';

/*Table structure for table `vic_wxapp` */

DROP TABLE IF EXISTS `vic_wxapp`;

CREATE TABLE `vic_wxapp` (
  `wxapp_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '小程序id',
  `app_id` varchar(50) NOT NULL DEFAULT '' COMMENT '小程序AppID',
  `app_secret` varchar(50) NOT NULL DEFAULT '' COMMENT '小程序AppSecret',
  `mchid` varchar(50) NOT NULL DEFAULT '' COMMENT '微信商户号id',
  `apikey` varchar(255) NOT NULL DEFAULT '' COMMENT '微信支付密钥',
  `cert_pem` longtext COMMENT '证书文件cert',
  `key_pem` longtext COMMENT '证书文件key',
  `is_recycle` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否回收',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`wxapp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10002 DEFAULT CHARSET=utf8 COMMENT='微信小程序记录表';

/*Table structure for table `vic_wxapp_category` */

DROP TABLE IF EXISTS `vic_wxapp_category`;

CREATE TABLE `vic_wxapp_category` (
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `category_style` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '分类页样式(10一级分类[大图] 11一级分类[小图] 20二级分类)',
  `share_title` varchar(100) NOT NULL DEFAULT '' COMMENT '分享标题',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`wxapp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信小程序分类页模板';

/*Table structure for table `vic_wxapp_formid` */

DROP TABLE IF EXISTS `vic_wxapp_formid`;

CREATE TABLE `vic_wxapp_formid` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `form_id` varchar(50) NOT NULL DEFAULT '' COMMENT '小程序form_id',
  `expiry_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `is_used` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否已使用',
  `used_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '使用时间',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10890 DEFAULT CHARSET=utf8 COMMENT='小程序form_id记录表';

/*Table structure for table `vic_wxapp_help` */

DROP TABLE IF EXISTS `vic_wxapp_help`;

CREATE TABLE `vic_wxapp_help` (
  `help_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '帮助标题',
  `content` text NOT NULL COMMENT '帮助内容',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序(数字越小越靠前)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`help_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10002 DEFAULT CHARSET=utf8 COMMENT='微信小程序帮助';

/*Table structure for table `vic_wxapp_page` */

DROP TABLE IF EXISTS `vic_wxapp_page`;

CREATE TABLE `vic_wxapp_page` (
  `page_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '页面id',
  `page_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '页面类型(10首页 20自定义页)',
  `page_name` varchar(255) NOT NULL DEFAULT '' COMMENT '页面名称',
  `page_data` longtext NOT NULL COMMENT '页面数据',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '微信小程序id',
  `is_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '软删除',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`page_id`),
  KEY `wxapp_id` (`wxapp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10006 DEFAULT CHARSET=utf8 COMMENT='微信小程序diy页面表';

/*Table structure for table `vic_wxapp_prepay_id` */

DROP TABLE IF EXISTS `vic_wxapp_prepay_id`;

CREATE TABLE `vic_wxapp_prepay_id` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单id',
  `order_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '订单类型(10商城订单 20拼团订单)',
  `prepay_id` varchar(50) NOT NULL DEFAULT '' COMMENT '微信支付prepay_id',
  `can_use_times` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可使用次数',
  `used_times` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '已使用次数',
  `pay_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '支付状态(1已支付)',
  `wxapp_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '小程序id',
  `expiry_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COMMENT='小程序prepay_id记录';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
