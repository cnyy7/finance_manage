/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80013
 Source Host           : localhost:3306
 Source Schema         : finance

 Target Server Type    : MySQL
 Target Server Version : 80013
 File Encoding         : 65001

 Date: 01/07/2019 23:49:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `IDX_414d4052f22837655ff312168c`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES (2, 'fafsddsdsssdfas', 'adsf', '04223cdf95b0b822fa3d17f2502f804f521286b9407efe4e8d1c55c90781a151');
INSERT INTO `account` VALUES (7, 'da', 'gdf', 'dfcf0b62400616f9d2621f1a697718b284600c25e0830e9dedf8c88089c7d164');
INSERT INTO `account` VALUES (9, 'fasdf', 'normal', '04223cdf95b0b822fa3d17f2502f804f521286b9407efe4e8d1c55c90781a151');
INSERT INTO `account` VALUES (10, 'fasd', 'normal', '04223cdf95b0b822fa3d17f2502f804f521286b9407efe4e8d1c55c90781a151');
INSERT INTO `account` VALUES (13, 'fa', 'normal', '04223cdf95b0b822fa3d17f2502f804f521286b9407efe4e8d1c55c90781a151');

-- ----------------------------
-- Table structure for balance
-- ----------------------------
DROP TABLE IF EXISTS `balance`;
CREATE TABLE `balance`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `datetime` datetime(0) NOT NULL,
  `money` double NOT NULL,
  `transFrom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `transTo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `memberId` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_74d9c418d95bb026fcdc70f7a72`(`memberId`) USING BTREE,
  CONSTRAINT `FK_74d9c418d95bb026fcdc70f7a72` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of balance
-- ----------------------------
INSERT INTO `balance` VALUES (1, 'afs', '2019-06-25 22:12:17', 2.3, 'fasdf', 'fsa', 2);
INSERT INTO `balance` VALUES (2, 'afs', '2019-06-25 22:12:42', 2.3, 'fasdf', 'fsa', 7);
INSERT INTO `balance` VALUES (8, 'd', '2019-07-01 11:11:51', 1.2, 'fa', 'fdsf', 31);

-- ----------------------------
-- Table structure for borrowing
-- ----------------------------
DROP TABLE IF EXISTS `borrowing`;
CREATE TABLE `borrowing`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `money` double NOT NULL,
  `beginTime` datetime(0) NOT NULL,
  `updateTime` datetime(0) NOT NULL,
  `transTo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `transToPhone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `memos` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `memberId` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_425b0963448e14be633554088ff`(`memberId`) USING BTREE,
  CONSTRAINT `FK_425b0963448e14be633554088ff` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrowing
-- ----------------------------
INSERT INTO `borrowing` VALUES (1, '借入', 990, '2019-06-26 13:24:32', '2019-06-26 13:24:32', 'fas', 'fsad', 'fasd', 7);
INSERT INTO `borrowing` VALUES (2, '借入', 10, '2019-07-01 19:57:23', '2019-07-01 19:57:23', 'fsd', 'fsd', 'fsadf', 31);

-- ----------------------------
-- Table structure for finance
-- ----------------------------
DROP TABLE IF EXISTS `finance`;
CREATE TABLE `finance`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `money` double NOT NULL,
  `beginTime` datetime(0) NOT NULL,
  `updateTime` datetime(0) NOT NULL,
  `memos` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `memberId` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_0b07e789ea567aed11474109fb0`(`memberId`) USING BTREE,
  CONSTRAINT `FK_0b07e789ea567aed11474109fb0` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of finance
-- ----------------------------
INSERT INTO `finance` VALUES (1, 'dsa', 'fads', 32.2, '2019-06-26 14:23:13', '2019-06-26 14:23:13', 'jlkj', 2);

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `control` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `age` int(11) NOT NULL,
  `accountId` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_c1012c9a3cdedf2b00510cdd845`(`accountId`) USING BTREE,
  CONSTRAINT `FK_c1012c9a3cdedf2b00510cdd845` FOREIGN KEY (`accountId`) REFERENCES `account` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (2, 'ccccccccc', '女', 'a', '23424', 102, 7);
INSERT INTO `member` VALUES (3, 'fasaffdssdad', '女', 'a', '23424', 12, 2);
INSERT INTO `member` VALUES (4, 'fasaffdssdad', '女', 'a', '23424', 12, 2);
INSERT INTO `member` VALUES (5, 'fasaffdssdad', '女', 'a', '23424', 12, 2);
INSERT INTO `member` VALUES (7, 'fasaffdssdad1', '女', 'a', '23424', 12, 7);
INSERT INTO `member` VALUES (14, 'fasaffdssdad', '女', 'a', '23424', 12, 2);
INSERT INTO `member` VALUES (17, 'fasaffdssdad', '女', 'a', '23424', 12, 2);
INSERT INTO `member` VALUES (30, 'fds', '女', 'fds', 'fsd', 2, 7);
INSERT INTO `member` VALUES (31, 'a', '男', 'a', 'a', 10, 7);
INSERT INTO `member` VALUES (32, 'fsd', '女', 'fsd', 'fds', 18, 7);
INSERT INTO `member` VALUES (33, 'fds', '女', 'fds', 'fds', 1, 7);
INSERT INTO `member` VALUES (34, 'fsd', '女', 'fds', 'fsd', 1, 7);
INSERT INTO `member` VALUES (38, '12', '女', '12', '12', 12, 7);

-- ----------------------------
-- Table structure for saving
-- ----------------------------
DROP TABLE IF EXISTS `saving`;
CREATE TABLE `saving`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bankName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cardNumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `beginTime` datetime(0) NOT NULL,
  `updateTime` datetime(0) NOT NULL,
  `memberId` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `IDX_69ffeb9fd5d53bd5733a0f371e`(`cardNumber`) USING BTREE,
  INDEX `FK_71047623e343fa1d68ef6131da0`(`memberId`) USING BTREE,
  CONSTRAINT `FK_71047623e343fa1d68ef6131da0` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of saving
-- ----------------------------
INSERT INTO `saving` VALUES (1, 'fads', 'fasdd', 'adsdf', '2020-07-02 21:20:39', '2021-06-24 21:18:39', 32);
INSERT INTO `saving` VALUES (2, 'fds', 'f\'d\'sfds', 'fds', '2019-05-29 15:04:13', '2019-06-26 15:04:18', 2);
INSERT INTO `saving` VALUES (3, 'afds', 'fasdf', 'fasd', '2019-06-30 22:48:39', '2019-06-30 22:48:41', 2);

SET FOREIGN_KEY_CHECKS = 1;
