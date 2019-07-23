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

 Date: 05/07/2019 20:13:14
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
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES (2, 'fasds', 'administrator', '04223cdf95b0b822fa3d17f2502f804f521286b9407efe4e8d1c55c90781a151');
INSERT INTO `account` VALUES (7, 'da', 'normal', '04223cdf95b0b822fa3d17f2502f804f521286b9407efe4e8d1c55c90781a151');
INSERT INTO `account` VALUES (9, 'fasdf', 'normal', '04223cdf95b0b822fa3d17f2502f804f521286b9407efe4e8d1c55c90781a151');
INSERT INTO `account` VALUES (10, 'fasd', 'normal', '04223cdf95b0b822fa3d17f2502f804f521286b9407efe4e8d1c55c90781a151');
INSERT INTO `account` VALUES (19, 'fdsafasf', 'normal', '04223cdf95b0b822fa3d17f2502f804f521286b9407efe4e8d1c55c90781a151');
INSERT INTO `account` VALUES (20, 'aaa', 'normal', '04223cdf95b0b822fa3d17f2502f804f521286b9407efe4e8d1c55c90781a151');
INSERT INTO `account` VALUES (21, 'dabbb', 'normal', '04223cdf95b0b822fa3d17f2502f804f521286b9407efe4e8d1c55c90781a151');
INSERT INTO `account` VALUES (28, '123', 'normal', '04223cdf95b0b822fa3d17f2502f804f521286b9407efe4e8d1c55c90781a151');
INSERT INTO `account` VALUES (29, 'da123', 'administrator', '04223cdf95b0b822fa3d17f2502f804f521286b9407efe4e8d1c55c90781a151');

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
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of balance
-- ----------------------------
INSERT INTO `balance` VALUES (1, 'afs', '2019-06-25 22:12:17', 2.3, 'fasdf', 'fsa', 2);
INSERT INTO `balance` VALUES (2, 'afs', '2019-06-25 22:12:42', 2, 'fasdf', 'fsa', 31);
INSERT INTO `balance` VALUES (8, 'd', '2019-07-01 11:11:51', 1.2, 'fa', 'fdsf', 31);
INSERT INTO `balance` VALUES (9, 'fdsa', '2019-07-04 14:49:33', 0.3, 'ds', 'sd', 30);
INSERT INTO `balance` VALUES (10, 'fdsa', '2019-07-04 19:37:50', 3.8, 'fd', 'fd', 7);

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
INSERT INTO `borrowing` VALUES (1, '借入', 89.4, '2019-06-26 13:24:32', '2019-07-02 15:26:25', 'fas', 'fsad', 'fasd', 7);
INSERT INTO `borrowing` VALUES (2, '借入', 10, '2019-07-01 19:57:23', '2019-07-02 15:26:33', 'fsd', 'fsd', 'fsadf', 31);
INSERT INTO `borrowing` VALUES (3, '借出', 40, '2019-07-05 13:21:32', '2019-07-05 13:21:32', 'fd', 'd', 'd', 32);

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
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of finance
-- ----------------------------
INSERT INTO `finance` VALUES (1, 'dsa', 'fads', 30.2, '2019-06-26 14:23:13', '2019-06-26 14:23:13', 'jlkj', 2);
INSERT INTO `finance` VALUES (3, 'dsa', 'da', 30, '2019-07-04 14:08:47', '2019-07-04 14:08:47', 'd', 7);
INSERT INTO `finance` VALUES (4, 'f\'s', 'fsfasf', 10, '2019-07-04 14:14:37', '2019-07-04 14:14:37', 'd', 32);
INSERT INTO `finance` VALUES (5, 'fadf', 'dsfds', 77.1, '2019-07-04 14:17:06', '2019-07-04 14:17:06', 'fs', 38);
INSERT INTO `finance` VALUES (6, 'fsdf', 'fsa', 70, '2019-07-04 14:23:15', '2019-07-04 14:23:15', 'd', 31);
INSERT INTO `finance` VALUES (7, 'fasf', 'fasd', 20, '2019-07-04 14:23:59', '2019-07-04 14:23:59', 'd', 7);
INSERT INTO `finance` VALUES (8, 'fsd', 'fds', 10, '2019-07-04 14:25:03', '2019-07-04 14:25:03', 'd', 7);
INSERT INTO `finance` VALUES (9, 'a', 'da', 30, '2019-07-04 14:43:44', '2019-07-04 14:43:44', 's', 30);

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
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (2, 'ccccccccc', '男', 'a', '23424', 99, 7);
INSERT INTO `member` VALUES (3, 'fasaffdssdad', '女', 'a', '23424', 12, 2);
INSERT INTO `member` VALUES (4, 'fasaffdssdad', '女', 'a', '23424', 12, 2);
INSERT INTO `member` VALUES (5, 'fasaffdssdad', '女', 'a', '23424', 12, 2);
INSERT INTO `member` VALUES (7, 'fasaffdssdad1', '女', 'a', '23424', 9, 7);
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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of saving
-- ----------------------------
INSERT INTO `saving` VALUES (1, 'fads', 'fasdd', 'adsdf', '2020-07-02 21:20:39', '2021-06-24 21:18:39', 32);
INSERT INTO `saving` VALUES (3, 'afds', 'fasdf', 'fasd', '2019-07-10 22:49:39', '2019-06-30 22:48:41', 2);
INSERT INTO `saving` VALUES (6, 'fds', 'fsad', 'fsd', '2019-07-05 13:21:03', '2019-07-05 13:21:03', 38);

SET FOREIGN_KEY_CHECKS = 1;
