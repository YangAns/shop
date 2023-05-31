/*
 Navicat MySQL Data Transfer

 Source Server         : 远程服务器
 Source Server Type    : MySQL
 Source Server Version : 50650
 Source Host           : 47.106.160.226:3306
 Source Schema         : shopping

 Target Server Type    : MySQL
 Target Server Version : 50650
 File Encoding         : 65001

 Date: 20/03/2023 22:23:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `loginName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录名',
  `password` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `realName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `createDate` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (4, 'admin', '123456', '超级管理员', '10086', '2021-12-12 15:58:56', NULL);
INSERT INTO `admin` VALUES (8, 'tom', '123456', '汤姆', '10086', '2021-12-01 21:31:41', NULL);
INSERT INTO `admin` VALUES (9, 'jack', '123456', '杰克', '10086', '2021-12-01 21:32:18', NULL);

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role`  (
  `aid` int(11) NULL DEFAULT NULL,
  `rid` int(11) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_role
-- ----------------------------
INSERT INTO `admin_role` VALUES (4, 1);
INSERT INTO `admin_role` VALUES (8, 4);
INSERT INTO `admin_role` VALUES (9, 5);

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `gid` int(11) NULL DEFAULT NULL COMMENT '商品id',
  `uid` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `num` int(11) NULL DEFAULT NULL COMMENT '购物车商品数量',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品单价',
  `totalPrice` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品总价',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '收藏编号',
  `gid` int(11) NULL DEFAULT NULL COMMENT '商品id',
  `uid` int(11) NULL DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for emailcode
-- ----------------------------
DROP TABLE IF EXISTS `emailcode`;
CREATE TABLE `emailcode`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '验证码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for evaluate
-- ----------------------------
DROP TABLE IF EXISTS `evaluate`;
CREATE TABLE `evaluate`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评价编号\r\n',
  `uid` int(11) NULL DEFAULT NULL COMMENT '商品id',
  `gid` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `grade` int(11) NULL DEFAULT NULL COMMENT '评价星级',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评价内容',
  `addTime` datetime NULL DEFAULT NULL COMMENT '评价时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品价格',
  `num` int(11) NULL DEFAULT NULL COMMENT '数量',
  `pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `typeIdOne` int(11) NULL DEFAULT NULL COMMENT '类别一级id',
  `typeIdTwo` int(11) NULL DEFAULT NULL COMMENT '类别二级id',
  `collectNum` int(11) NULL DEFAULT NULL COMMENT '收藏数量',
  `buyNum` int(11) NULL DEFAULT NULL COMMENT '购买数量',
  `discount` int(11) NULL DEFAULT NULL COMMENT '折扣',
  `details` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '商品详情',
  `addTime` datetime NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (3, '华为p40', 5000.00, 1989, '20220323/6898f3006323422e84dfff484d64c04d.jpg', 2, 6, 0, 0, NULL, '<img src=\"/shop/upload/20220426/adfaefd130b740249cb9fa0d0a5630ca.jpg\" alt=\"undefined\">', '2021-11-18 00:00:00');
INSERT INTO `goods` VALUES (5, '华为nova5pro', 3000.00, 19792, '20211109/0893910f7ebb4806928a0b08d265b418.jpg', 2, 6, 5, 0, NULL, '<div class=\"p-parameter\"><p></p><ul id=\"parameter-brand\" class=\"p-parameter-list\"><li title=\"诺基亚（NOKIA）\">品牌：&nbsp;华为nova5pro</li></ul><p></p><p></p><ul class=\"parameter2 p-parameter-list\"><li title=\"诺基亚C20 Plus\">商品名称：华为nova5pro</li></ul><p></p><ul class=\"parameter2 p-parameter-list\"><li title=\"100022569730\">商品编号：100022569730</li><li title=\"200.00g\">商品毛重：200.00g</li><li title=\"中国大陆\">商品产地：中国大陆</li><li title=\"其他\">CPU型号：其他</li><li title=\"3GB\">运行内存：3GB</li><li title=\"32GB\">机身存储：32GB</li><li title=\"支持MicroSD(TF)\">存储卡：支持MicroSD(TF)</li><li title=\"后置双摄\">摄像头数量：后置双摄</li><li title=\"800万像素\">后摄主摄像素：800万像素</li><li title=\"500万像素\">前摄主摄像素：500万像素</li><li title=\"高清HD+\">分辨率：高清HD+</li><li title=\"19.6~20:9\">屏幕比例：19.6~20:9</li><li title=\"水滴屏\">屏幕前摄组合：水滴屏</li><li title=\"其他\">充电器：其他</li><li title=\"Android\">系统：Android</li><li title=\"超大字体，超大音量，SOS功能，语音命令，语音识别(文字语音互转)，极简桌面模式\">功能：超大字体，超大音量，SOS功能，语音命令，语音识别(文字语音互转)，极简桌面模式</li><li title=\"支持IPv6\">支持IPv6：支持IPv6</li><li title=\"智能机(老龄模式)\">老人机配置：智能机(老龄模式)</li></ul><p class=\"more-par\" style=\"text-align: left;\"><img src=\"/shop/upload/20220426/62a64e96781d483bb569a6daa4ec0df3.jpg\" alt=\"undefined\"><br></p></div><div id=\"J-detail-pop-tpl-top-new\" clstag=\"shangpin|keycount|product|pop-glbs\"><div class=\"ssd-module-wrap ssd-format-wrap\"><div class=\"ssd-format-floor ssd-floor-shopPrior\"><div skudesign=\"100010\" class=\"ssd-floor-type\" data-type=\"shopPrior\"></div><div id=\"zbViewFloorHeight_shopPrior\" value=\"1200\"></div><div class=\"ssd-module M15977396878931 animate-M15977396878931\" data-id=\"M15977396878931\"><div class=\"ssd-widget-text W16233973950011\"></div></div></div></div></div>', '2021-11-18 00:00:00');
INSERT INTO `goods` VALUES (7, '索尼数码相机', 14099.00, 1967, '20220520/524037c8fe8a40a096e1fd32e2e060ad.jpg', 14, 23, 10, 0, NULL, '<img src=\"/shop/upload/20220426/8679351635e54af8bf6062c30c309238.jpg\" alt=\"undefined\">', '2021-11-18 00:00:00');
INSERT INTO `goods` VALUES (12, '智能手环手表', 133.00, 1992, '20211125/334103893f304605b170eaa822cb9b72.jpg', 17, 26, 0, 2, NULL, '<img src=\"/shop/upload/20220426/7009c92be106444b9d2e1df61af9ae0f.jpg\" alt=\"undefined\">', '2021-11-15 00:00:00');
INSERT INTO `goods` VALUES (13, '戴尔轻薄学生游戏办公手提笔记本', 4069.00, 991, '20220323/66336fa2bc684f1598bbe0babf0ffee6.jpg', 27, 41, 4, 4, NULL, '<img src=\"/shop/upload/20220426/caab1bfedb734b5aa1849673e4b4f645.jpg\" alt=\"undefined\">', '2022-03-23 00:00:00');
INSERT INTO `goods` VALUES (14, '科大讯飞无线蓝牙鼠标', 199.00, 979, '20220323/8305768e3b1347829537d6a930479dd0.jpg', 27, 28, 12, 9, NULL, '<img src=\"/shop/upload/20220426/3d92a52974984d1681c1ac6470fe8661.jpg\" alt=\"undefined\">', '2022-03-23 00:00:00');
INSERT INTO `goods` VALUES (15, '戴尔（DELL）KB216 键盘', 40.90, 954, '20220323/8f5d8a04ba7745ffb2e0712f1865aee5.jpg', 27, 28, 5, 46, NULL, '<img src=\"/shop/upload/20220426/a5ed4845e81f4eb2931fd7a98d964fb2.jpg\" alt=\"undefined\">', '2022-03-23 00:00:00');
INSERT INTO `goods` VALUES (16, '漫步者 （EDIFIER） LolliPods', 178.00, 994, '20220323/1bc97dd4c2714bce8ccd2d4dc236a0fe.jpg', 30, 39, 1, 6, NULL, '<img src=\"/shop/upload/20220426/fbcaa095a1cd45af925955c9642dbe4a.jpg\" alt=\"undefined\">', '2022-03-23 00:00:00');
INSERT INTO `goods` VALUES (17, '联想(Lenovo) 电脑音响音箱', 56.00, 990, '20220323/dfde02e4cd2b4b79afbcf3b651e8a5d7.jpg', 30, 40, 0, 10, NULL, '<img src=\"/shop/upload/20220426/6fc197f6bae44deaa48cb47dcbeb8cae.jpg\" alt=\"undefined\">', '2022-03-23 00:00:00');
INSERT INTO `goods` VALUES (18, 'LOPOM【双摄+智能避障】高清无人机', 199.00, 1000, '20220323/d385526520da419eaa461dea16d7f2a9.jpg', 32, 42, 0, 0, NULL, '<img src=\"/shop/upload/20220426/57c9f45f7fdf4c4d81f600b9fa6230d1.jpg\" alt=\"undefined\">', '2022-03-23 00:00:00');

-- ----------------------------
-- Table structure for goods_type
-- ----------------------------
DROP TABLE IF EXISTS `goods_type`;
CREATE TABLE `goods_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NULL DEFAULT NULL,
  `typeName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods_type
-- ----------------------------
INSERT INTO `goods_type` VALUES (2, NULL, '智能手机');
INSERT INTO `goods_type` VALUES (6, 2, '华为手机');
INSERT INTO `goods_type` VALUES (14, NULL, '摄影摄像');
INSERT INTO `goods_type` VALUES (17, NULL, '数码配件');
INSERT INTO `goods_type` VALUES (19, 2, '小米手机');
INSERT INTO `goods_type` VALUES (23, 14, '数码相机');
INSERT INTO `goods_type` VALUES (24, 14, '单反镜头');
INSERT INTO `goods_type` VALUES (25, 17, '华为手表');
INSERT INTO `goods_type` VALUES (26, 17, '小米手环');
INSERT INTO `goods_type` VALUES (27, NULL, '电脑笔记本');
INSERT INTO `goods_type` VALUES (28, 27, '鼠标键盘');
INSERT INTO `goods_type` VALUES (29, 27, '显示器');
INSERT INTO `goods_type` VALUES (30, NULL, '影音娱乐');
INSERT INTO `goods_type` VALUES (31, NULL, '商务办公');
INSERT INTO `goods_type` VALUES (32, NULL, '智能设备');
INSERT INTO `goods_type` VALUES (33, NULL, '网络产品');
INSERT INTO `goods_type` VALUES (34, NULL, '乐器');
INSERT INTO `goods_type` VALUES (36, 17, '小米手表');
INSERT INTO `goods_type` VALUES (37, 17, '耳机套');
INSERT INTO `goods_type` VALUES (38, 14, '摄影脚架');
INSERT INTO `goods_type` VALUES (39, 30, '耳机耳麦');
INSERT INTO `goods_type` VALUES (40, 30, '音响');
INSERT INTO `goods_type` VALUES (41, 27, '笔记本电脑');
INSERT INTO `goods_type` VALUES (42, 32, '无人机');
INSERT INTO `goods_type` VALUES (43, 32, '平衡车');
INSERT INTO `goods_type` VALUES (44, 32, '儿童智能手表');
INSERT INTO `goods_type` VALUES (45, 31, '照片打印机');
INSERT INTO `goods_type` VALUES (46, 33, '无线网卡');
INSERT INTO `goods_type` VALUES (47, 33, '路由器');
INSERT INTO `goods_type` VALUES (48, 34, '吉他');
INSERT INTO `goods_type` VALUES (49, 34, '电子琴');
INSERT INTO `goods_type` VALUES (50, NULL, '生活家电');
INSERT INTO `goods_type` VALUES (56, 50, '洗衣机');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单编号',
  `pid` int(11) NULL DEFAULT 0 COMMENT '所属父级菜单编号',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `href` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '打开链接地址',
  `spread` int(11) NULL DEFAULT 0 COMMENT '是否展开',
  `target` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '打开方式',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标样式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, 0, '商品管理', '', 0, '_self', 'fa fa-briefcase');
INSERT INTO `menu` VALUES (2, 1, '商品列表', '/shop/admin/toGoodsManager', 0, '_self', 'fa fa-bars');
INSERT INTO `menu` VALUES (3, 1, '类型列表', '/shop/admin/toGoodsTypeOneManager', 0, '_self', 'fa fa-plus-square-o');
INSERT INTO `menu` VALUES (4, 0, '客户管理', '', 0, '_self', 'fa fa-user');
INSERT INTO `menu` VALUES (5, 4, '查看客户', '/shop/admin/toUserManager', 0, '_self', 'fa fa-anchor');
INSERT INTO `menu` VALUES (6, 0, '订单管理', '', 0, '_self', 'fa fa-plus-square');
INSERT INTO `menu` VALUES (7, 6, '订单列表', '/shop/admin/toOrderManager', 0, '_self', 'fa fa-book');
INSERT INTO `menu` VALUES (8, 0, '评价管理', NULL, 0, '_self', 'fa fa-check-square-o');
INSERT INTO `menu` VALUES (9, 8, '评价列表', '/shop/admin/toEvaluateManager', 0, '_self', 'fa fa-edit');
INSERT INTO `menu` VALUES (12, 0, '权限管理', NULL, 0, '_self', 'fa fa-key');
INSERT INTO `menu` VALUES (13, 12, '角色管理', '/shop/admin/toRoleManager', 0, '_self', 'fa fa-lock');
INSERT INTO `menu` VALUES (14, 12, '管理员管理', '/shop/admin/toAdminManager', 0, '_self', 'fa fa-male');
INSERT INTO `menu` VALUES (15, 0, '公告管理', NULL, 0, '_self', 'fa fa-credit-card');
INSERT INTO `menu` VALUES (16, 15, '公告列表', '/shop/admin/toNoticeManager', 0, '_self', 'fa fa-bar-chart');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公告标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '公告内容',
  `addTime` datetime NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `orderCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `uid` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `addTime` datetime NULL DEFAULT NULL COMMENT '下单时间',
  `orderPrice` decimal(10, 2) NULL DEFAULT NULL COMMENT '订单总价',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for orderdetail
-- ----------------------------
DROP TABLE IF EXISTS `orderdetail`;
CREATE TABLE `orderdetail`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '详情编号',
  `gid` int(11) NULL DEFAULT NULL COMMENT '商品id',
  `orderId` int(11) NULL DEFAULT NULL COMMENT '订单id',
  `detailNum` int(11) NULL DEFAULT NULL COMMENT '详情数量',
  `detailPrice` decimal(10, 2) NULL DEFAULT NULL COMMENT '详情价格',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `roledesc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '超级管理员', '拥有所有权限操作');
INSERT INTO `role` VALUES (2, '商品管理员', '管理商品');
INSERT INTO `role` VALUES (4, '用户管理员', '管理前台用户');
INSERT INTO `role` VALUES (5, '订单管理员', '负责订单的发货与查看');

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu`  (
  `mid` int(11) NULL DEFAULT NULL,
  `rid` int(11) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES (1, 1);
INSERT INTO `role_menu` VALUES (2, 1);
INSERT INTO `role_menu` VALUES (3, 1);
INSERT INTO `role_menu` VALUES (4, 1);
INSERT INTO `role_menu` VALUES (5, 1);
INSERT INTO `role_menu` VALUES (6, 1);
INSERT INTO `role_menu` VALUES (7, 1);
INSERT INTO `role_menu` VALUES (8, 1);
INSERT INTO `role_menu` VALUES (9, 1);
INSERT INTO `role_menu` VALUES (10, 1);
INSERT INTO `role_menu` VALUES (11, 1);
INSERT INTO `role_menu` VALUES (12, 1);
INSERT INTO `role_menu` VALUES (13, 1);
INSERT INTO `role_menu` VALUES (14, 1);
INSERT INTO `role_menu` VALUES (15, 1);
INSERT INTO `role_menu` VALUES (16, 1);
INSERT INTO `role_menu` VALUES (4, 4);
INSERT INTO `role_menu` VALUES (5, 4);
INSERT INTO `role_menu` VALUES (1, 2);
INSERT INTO `role_menu` VALUES (2, 2);
INSERT INTO `role_menu` VALUES (3, 2);
INSERT INTO `role_menu` VALUES (6, 5);
INSERT INTO `role_menu` VALUES (7, 5);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '客户编号',
  `userName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `realName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 83 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
