CREATE TABLE `user` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID',
`username` varchar(32) NOT NULL COMMENT '用户名',
`password` varchar(128) NULL DEFAULT NULL COMMENT '密码',
`realname` varchar(16) NULL COMMENT '真实姓名',
`area` varchar(32) NULL COMMENT '区域',
`gender` tinyint(2) UNSIGNED NULL DEFAULT 1 COMMENT '性别: {0:女, 1:男, 2:保密}',
`mobile` varchar(16) NULL COMMENT '手机号码',
`tel` varchar(16) NULL COMMENT '座机',
`email` varchar(64) NULL COMMENT '电子邮箱',
`level` tinyint UNSIGNED NULL DEFAULT 1 COMMENT '等级',
`balance` decimal(9,2) NULL COMMENT '账户余额',
`status` tinyint NULL DEFAULT 0 COMMENT '状态: {0:未激活,1:已激活,2:已禁用}',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) ,
UNIQUE INDEX `unique_username` (`username` ASC)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = '用户表';

CREATE TABLE `user_rel_wechat_app` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`wechat_app_id` int(11) UNSIGNED NOT NULL,
`user_id` int(11) NULL COMMENT '用户ID',
`openid` varchar(64) NULL COMMENT '微信openid',
`nickname` varchar(32) NULL COMMENT '微信昵称',
`headicon` varchar(256) NULL COMMENT '头像',
`access_token` varchar(512) NULL COMMENT '微信用户登陆凭证',
`access_token_expire` int(11) UNSIGNED NULL COMMENT '微信用户登陆凭证过期时间',
`refresh_token` varchar(512) NULL COMMENT '微信用户刷新凭证',
`refresh_token_expire` int(11) NULL COMMENT '微信用户刷新凭证过期时间',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '用户微信app关联表';

CREATE TABLE `user_addr` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`user_id` int(11) UNSIGNED NOT NULL COMMENT '用户ID',
`realname` varchar(16) NOT NULL COMMENT '真实姓名',
`phone` varchar(16) NOT NULL COMMENT '手机/座机',
`province` varchar(32) NULL COMMENT '省',
`city` varchar(32) NULL COMMENT '市',
`county` varchar(32) NULL COMMENT '县',
`township` varchar(32) NULL COMMENT '乡镇',
`zipcode` varchar(16) NULL COMMENT '邮编',
`longitude` varchar(64) NULL COMMENT '地理位置经度',
`latitude` varchar(64) NULL COMMENT '地理位置纬度',
`precision` varchar(16) NULL COMMENT '地理位置精度',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '用户地址表';

CREATE TABLE `supplier` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`username` varchar(32) NOT NULL COMMENT '用户名',
`password` varchar(128) NOT NULL COMMENT '密码',
`supplier_type` int(4) NOT NULL DEFAULT 0 COMMENT '供应商类型: {0:第三方供应商 , 1:自营}',
`supplier_name` varchar(32) NOT NULL COMMENT '供应商名称',
`area` varchar(255) NOT NULL COMMENT '区域',
`mobile` varchar(16) NOT NULL COMMENT '负责人手机',
`tel` varchar(16) NULL COMMENT '负责人座机',
`email` varchar(128) NULL COMMENT '负责人email',
`status` tinyint NOT NULL DEFAULT 0 COMMENT '状态: {0: 未审核 1:审核通过 2:禁用}',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '供应商表';

CREATE TABLE `user_rel_shop` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`user_id` int(11) NOT NULL,
`shop_id` int(11) NOT NULL,
`is_checked` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否选中',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '用户绑定自提店表';

CREATE TABLE `wechat_app` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`app_name` varchar(32) NOT NULL COMMENT 'app名称',
`app_id` varchar(64) NULL COMMENT '微信开放平台的app_id',
`app_key` varchar(255) NULL,
`access_token` varchar(512) NULL COMMENT '微信访问凭据',
`access_token_expire` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '微信访问凭据过期时间',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '微信app表';

CREATE TABLE `admin` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`username` varchar(32) NOT NULL,
`password` varchar(128) NULL,
`admin_role_id` int(4) NULL COMMENT '角色ID',
`company_name` varchar(0) NULL COMMENT '公司名',
`realname` varchar(32) NULL,
`mobile` varchar(16) NOT NULL,
`email` varchar(128) NULL,
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '管理员表(总、分公司)';

CREATE TABLE `setting` (
`key` varchar(64) NOT NULL COMMENT '键',
`value` varchar(8000) NULL COMMENT '值',
`value_type` varchar(32) NULL COMMENT '值类型',
`group` varchar(0) NULL COMMENT '分组',
PRIMARY KEY (`key`) ,
UNIQUE INDEX `unique_key` (`key` ASC)
)
COMMENT = '配置表';

CREATE TABLE `admin_role` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`role_name` varchar(32) NULL,
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `message` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`sender_id` int(11) NOT NULL COMMENT '发送人ID',
`sender_type` varchar(32) NOT NULL COMMENT '发送人类型: {user:客户, shop:店东, supplier: 供应商, admin:总、分公司}',
`sender_name` varchar(32) NOT NULL COMMENT '发送人名称',
`message_type` varchar(16) NOT NULL COMMENT '信息类型: {private:私信, public:站内通知, group:群组通知}',
`content` varchar(8000) NOT NULL COMMENT '信息内容',
`status` tinyint NULL DEFAULT 0 COMMENT '状态: {0:未读 1:已读}',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '站内信表';

CREATE TABLE `message_status` (
`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
`message_id` bigint(20) UNSIGNED NOT NULL COMMENT '信息ID',
`receiver_id` int(11) UNSIGNED NOT NULL COMMENT '收信人ID',
`receiver_type` varchar(32) NULL COMMENT '收信人类型: {user:客户, shop:店东, supplier: 供应商, admin:总、分公司}',
`status` tinyint NULL DEFAULT 0 COMMENT '状态: {0:未读 1:已读}',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '信息状态表';

CREATE TABLE `order` (
`id` bigint(20) UNSIGNED NOT NULL COMMENT '订单ID',
`order_origin_id` bigint(20) UNSIGNED NULL COMMENT '原始订单号',
`title` varchar(64) NOT NULL COMMENT '订单标题',
`user_id` int(11) NOT NULL COMMENT '用户ID',
`shop_id` int(11) UNSIGNED NOT NULL COMMENT '提货点ID',
`quantity` decimal(9,2) NOT NULL,
`amount` decimal(9,2) NOT NULL COMMENT '总金额（未计算折扣优惠的总金额）',
`payment` decimal(9,2) NOT NULL COMMENT '应付金额 （去掉优惠金额后的实际应付金额）',
`discount` decimal(9,2) NOT NULL,
`weight` decimal(9,4) NULL COMMENT '重量',
`addr_id` int(11) UNSIGNED NOT NULL COMMENT '收货地址ID',
`phone` varchar(16) NOT NULL COMMENT '收货人联系电话',
`remark` varchar(128) NULL COMMENT '订单备注',
`waybill_no` varchar(32) NULL COMMENT '运单号',
`express_company` varchar(32) NULL COMMENT '快递公司',
`pickup_method` varchar(16) NULL COMMENT '提货方式',
`status` varchar(16) NULL COMMENT '订单状态',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `order_detail` (
`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '子订单ID',
`order_origin_id` bigint(20) UNSIGNED NOT NULL COMMENT '原始订单号',
`order_id` bigint(20) UNSIGNED NOT NULL COMMENT '订单ID',
`sku_id` int(11) UNSIGNED NOT NULL COMMENT 'SKU ID',
`supplier_id` int(11) UNSIGNED NOT NULL COMMENT '供应商ID',
`quantity` float(8,2) NOT NULL COMMENT '商品数量',
`title` varchar(255) NOT NULL COMMENT '商品标题',
`bn` varchar(32) NOT NULL COMMENT '商品自编码',
`barcode` varchar(16) NOT NULL COMMENT '商品条形码',
`amount` decimal(9,2) NOT NULL,
`discount` decimal(9,2) NOT NULL,
`payment` decimal(9,2) NOT NULL,
`promotion_id` int(11) UNSIGNED NULL COMMENT '促销ID',
`price` decimal(9,4) NOT NULL COMMENT '售价',
`profit_rate` decimal(9,4) NULL COMMENT '自提店分润百分比',
`subcompany_profit_rate` decimal(9,4) NULL COMMENT '子公司分润百分比',
`parentcompany_profit_rate` decimal(9,4) NULL COMMENT '总公司分润百分比',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `shop` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`user_id` int(11) NOT NULL COMMENT '关联的用户ID',
`shop_name` varchar(32) NOT NULL COMMENT '自提店名称',
`opening_time` varchar(16) NOT NULL COMMENT '开始营业时间',
`closing_time` varchar(16) NOT NULL COMMENT '结束营业时间',
`status` tinyint NOT NULL DEFAULT 0 COMMENT '状态: {0: 未审核 1:已审核 2:已禁用}',
`reg_ip` varchar(32) NOT NULL COMMENT '注册IP',
`logo` varchar(512) NULL COMMENT 'logo',
`admin_id` int(11) UNSIGNED NOT NULL COMMENT '所属分公司',
`profit_rate` decimal(9,4) NOT NULL COMMENT '提成分润',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '自提店表';

CREATE TABLE `order_origin` (
`id` bigint(20) NOT NULL,
`user_id` int(11) UNSIGNED NOT NULL,
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '原始订单表(购物车商品提交时的原始单号)';

CREATE TABLE `payment` (
`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
`user_id` int(11) NOT NULL COMMENT '用户ID',
`title` varchar(32) NULL,
`method` varchar(32) NULL COMMENT '支付方式',
`order_no` varchar(64) NULL COMMENT '支付流水号',
`status` tinyint NULL DEFAULT 0 COMMENT '支付状态: {0:未支付 1:已支付 2:取消支付}',
`amount` decimal(9,2) NOT NULL COMMENT '需支付金额',
`paid_amount` decimal(9,2) NULL COMMENT '已支付金额',
`remark` varchar(255) NULL COMMENT '备注',
`ip` varchar(32) NULL COMMENT '支付人IP',
`paid_at` int(11) NULL COMMENT '支付时间',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '支付信息表';

CREATE TABLE `payment_detail` (
`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
`payment_id` bigint(20) UNSIGNED NOT NULL,
`user_id` int(11) UNSIGNED NOT NULL COMMENT '用户ID',
`order_id` bigint(20) NULL COMMENT '订单ID',
`paid_at` int(11) NULL DEFAULT NULL,
`status` tinyint NOT NULL DEFAULT 0 COMMENT '支付状态: {0:未支付 1:已支付 2:取消支付}',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '支付详情表';

CREATE TABLE `cart` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`user_id` int(11) UNSIGNED NOT NULL,
`item_id` int(11) UNSIGNED NOT NULL,
`sku_id` int(11) UNSIGNED NOT NULL,
`quantity` int(11) UNSIGNED NOT NULL COMMENT '数量',
`pic` varchar(255) NULL,
`selected_promotion_id` int(11) NULL COMMENT '已选择的促销活动',
`is_checked` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '选中状态 {0:未选中 1:已选中}',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '购物车表';

CREATE TABLE `ad` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`admin_id` int(11) NOT NULL,
`title` varchar(64) NOT NULL,
`pos_id` int(11) NOT NULL,
`ad_type` varchar(32) NULL COMMENT '广告类型 {pic:图片地址  json:JSON字符串 html:HTML}',
`content` varchar(8000) NULL,
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '广告表';

CREATE TABLE `item` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`title` varchar(255) NOT NULL COMMENT '商品标题',
`barcode` varchar(32) NOT NULL COMMENT '商品条码',
`cat_id` int(11) UNSIGNED NOT NULL COMMENT '分类ID',
`brand_id` int(11) UNSIGNED NULL COMMENT '品牌ID',
`cost_price` decimal(9,4) NULL COMMENT '进价',
`weight` decimal(9,4) NULL COMMENT '重量',
`pic` varchar(512) NULL COMMENT '默认图片',
`pics` varchar(8000) NULL COMMENT '图片列表，以逗号分隔',
`is_self_build` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否是自建商品',
`is_virtual` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否是虚拟物品 {0:不是 1:是}',
`status` tinyint NOT NULL DEFAULT 0 COMMENT '状态 {0:未审核 1:审核通过 2:审核未通过}',
`unit` varchar(8) NULL COMMENT '最小销售包装单位',
`length` decimal(9,4) NULL COMMENT '长',
`width` decimal(9,4) NULL COMMENT '宽',
`height` decimal(9,4) NULL COMMENT '高',
`producing_area` varchar(32) NULL COMMENT '产地',
`description` varchar(255) NULL COMMENT '商品描述',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '商品表';

CREATE TABLE `category` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`cat_name` varchar(64) NOT NULL COMMENT '分类名称',
`parent_id` int(11) UNSIGNED NOT NULL COMMENT '上级分类ID',
`top_cat_id` int(11) UNSIGNED NOT NULL COMMENT '顶级分类ID',
`level` tinyint NOT NULL COMMENT '级数',
`logo` varchar(512) NULL COMMENT '分类logo',
`is_disabled` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否禁用 {0: 未禁用 1:禁用}',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '分类表';

CREATE TABLE `brand` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`brand_name` varchar(32) NOT NULL COMMENT '品牌名称',
`alias_name` varchar(64) NULL COMMENT '别名',
`is_self_build` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否是自建品牌',
`logo` varchar(512) NULL COMMENT '品牌logo',
`is_disabled` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否禁用 {0: 未禁用 1:禁用}',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '品牌表';

CREATE TABLE `category_rel_brand` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`cat_id` int(11) UNSIGNED NOT NULL,
`brand_id` int(11) UNSIGNED NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '分类品牌关联表';

CREATE TABLE `item_sku` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`title` varchar(255) NOT NULL COMMENT '商品标题',
`item_id` int(11) UNSIGNED NOT NULL,
`bn` varchar(32) NULL COMMENT '货号',
`production_date` varchar(16) NULL COMMENT '生产日期',
`packing_qty` int(11) UNSIGNED NULL COMMENT '箱包装数量',
`packing_unit` varchar(16) NULL COMMENT '箱包装数量',
`is_whole` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '是否是整件商品 {0:散卖商品 1:整件商品}',
`is_bundle` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否是捆绑销售',
`MOQ` int(8) UNSIGNED NOT NULL DEFAULT 1 COMMENT '最小起订量 如果是整件商品的话则表示件数',
`price` decimal(9,4) NOT NULL,
`rank` int(11) NOT NULL DEFAULT 0,
`supplier_id` int(11) UNSIGNED NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = 'SKU表';

CREATE TABLE `ad_postion` (
`id` int(11) NOT NULL,
`title` varchar(128) NOT NULL,
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '广告位置表';

CREATE TABLE `category_attr` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`cat_id` int(11) UNSIGNED NOT NULL COMMENT '分类ID',
`attr_id` int(11) UNSIGNED NOT NULL COMMENT '属性ID',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '分类属性表';

CREATE TABLE `attribute` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`attr_name` varchar(32) NOT NULL,
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '属性表';

CREATE TABLE `attribute_value` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`attr_id` int(11) UNSIGNED NOT NULL,
`value` varchar(64) NOT NULL,
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '属性值表';

CREATE TABLE `item_sku_attr` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`sku_id` int(11) UNSIGNED NOT NULL,
`cat_attr_id` int(11) NOT NULL,
`attr_value_id` int(11) NOT NULL,
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `user_rel_wechat_info` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`user_id` int(11) UNSIGNED NOT NULL,
`unionid` varchar(32) NULL COMMENT '微信unionid',
`headicon` varchar(256) NULL,
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `storage` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`storage_name` varchar(0) NULL COMMENT '仓库名称',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '仓库表';

CREATE TABLE `item_sku_store` (
`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
`sku_id` int(11) UNSIGNED NOT NULL COMMENT 'SKU ID',
`storage_id` int(11) NOT NULL COMMENT '仓库ID',
`item_id` int(11) NOT NULL,
`quantity` int(11) NOT NULL COMMENT '库存数',
`freeze` int(11) NULL COMMENT '冻结数',
PRIMARY KEY (`id`) 
)
COMMENT = 'SKU库存表';

CREATE TABLE `item_store` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`item_id` int(11) UNSIGNED NOT NULL COMMENT '商品ID',
`quantity` int(11) NOT NULL COMMENT '库存数',
`freeze` int(11) NOT NULL DEFAULT 0 COMMENT '冻结数',
PRIMARY KEY (`id`) 
)
COMMENT = '商品库存';

CREATE TABLE `shop_balance_log` (
`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
`shop_id` int(11) UNSIGNED NOT NULL,
`amount` decimal(9,2) NOT NULL COMMENT '操作金额',
`msg` varchar(128) NULL COMMENT '日志消息',
`created_at` int(11) UNSIGNED NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '自提店余额操作日志';

CREATE TABLE `item_sku_store_batch` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`sku_id` int(11) UNSIGNED NOT NULL,
`productiong_date` varchar(16) NULL,
`quantity` int(11) UNSIGNED NOT NULL,
`freez` int(11) UNSIGNED NOT NULL,
`storage_id` int(11) UNSIGNED NOT NULL COMMENT '仓库ID',
`supplier_id` int(11) NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '库存批次表';

CREATE TABLE `promotion` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`promotion_type` varchar(24) NOT NULL,
`promotion_name` varchar(32) NOT NULL,
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) UNSIGNED NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '促销表';

CREATE TABLE `promotion_preorder` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '提成分润',
`promotion_id` int(11) NOT NULL,
`sku_id` int(11) UNSIGNED NOT NULL,
`profit_rate` decimal(9,4) NOT NULL COMMENT '店东分润百分比',
`parentcompany_profit_rate` decimal(9,4) NULL COMMENT '总公司分润百分比',
`price` decimal(9,4) NOT NULL COMMENT '预售价',
`notice_time` int(11) UNSIGNED NOT NULL COMMENT '预告时间',
`begin_time` int(11) UNSIGNED NOT NULL COMMENT '开始时间',
`end_time` int(11) UNSIGNED NOT NULL COMMENT '结束时间',
`pickup_time` int(11) UNSIGNED NOT NULL COMMENT '预计可自提时间',
`description` varchar(255) NULL COMMENT '简短描述',
`content` text NOT NULL COMMENT '活动详情',
`created_at` int(11) UNSIGNED NOT NULL,
`updated_at` int(11) NOT NULL,
`deleted_at` int(11) UNSIGNED NULL DEFAULT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '预售表';

CREATE TABLE `shop_order_profit_rate` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`shop_id` int(11) UNSIGNED NOT NULL COMMENT '自提店ID',
`order_id` bigint(20) UNSIGNED NOT NULL,
`profit_rate_amount` decimal(9,2) NOT NULL COMMENT '提成金额',
`created_at` int(11) UNSIGNED NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '自提店订单分润表';

CREATE TABLE `shop_order_detail_profit_rate` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`shop_id` int(11) UNSIGNED NOT NULL COMMENT '自提店ID',
`order_id` bigint(20) UNSIGNED NOT NULL,
`order_detail_id` int(20) UNSIGNED NOT NULL COMMENT '订单详情ID',
`profit_rate_amount` decimal(9,2) NOT NULL COMMENT '提成金额',
`created_at` int(11) UNSIGNED NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '自提店订单分润表';

CREATE TABLE `item_sku_count` (
`sku_id` int(11) UNSIGNED NOT NULL,
`count` int(11) UNSIGNED NULL DEFAULT 0,
PRIMARY KEY (`sku_id`) ,
UNIQUE INDEX `unique_sku_id` (`sku_id` ASC)
)
COMMENT = '商品销量统计表';

CREATE TABLE `subcompany_order_profit_rate` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`admin_id` int(11) UNSIGNED NOT NULL COMMENT '自提店ID',
`order_id` bigint(20) UNSIGNED NOT NULL,
`profit_rate_amount` decimal(9,2) NOT NULL COMMENT '提成金额',
`created_at` int(11) UNSIGNED NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '自提店订单分润表';

CREATE TABLE `parentcompany_order_profit_rate` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`admin_id` int(11) UNSIGNED NOT NULL COMMENT '自提店ID',
`order_id` bigint(20) UNSIGNED NOT NULL,
`profit_rate_amount` decimal(9,2) NOT NULL COMMENT '提成金额',
`created_at` int(11) UNSIGNED NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT = '自提店订单分润表';
