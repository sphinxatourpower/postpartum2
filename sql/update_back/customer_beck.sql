-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- 主機: 127.0.0.1
-- 產生日期: 2013 年 12 月 03 日 10:27
-- 伺服器版本: 5.5.32
-- PHP 版本: 5.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 資料庫: `postpartum_wu`
--

-- --------------------------------------------------------

--
-- 表的結構 `customer_beck`
--

CREATE TABLE IF NOT EXISTS `customer_beck` (
  `customer_beck_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `date_added` date NOT NULL,
  `date_modify` date NOT NULL,
  `score` int(11) NOT NULL,
  `chk1` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk2` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk3` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk4` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk5` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk6` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk7` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk8` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk9` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk10` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk11` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk12` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk13` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk14` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk15` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk16` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk17` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk18` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk19` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk20` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `chk21` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`customer_beck_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

--
-- 轉存資料表中的資料 `customer_beck`
--

INSERT INTO `customer_beck` (`customer_beck_id`, `customer_id`, `date_added`, `date_modify`, `score`, `chk1`, `chk2`, `chk3`, `chk4`, `chk5`, `chk6`, `chk7`, `chk8`, `chk9`, `chk10`, `chk11`, `chk12`, `chk13`, `chk14`, `chk15`, `chk16`, `chk17`, `chk18`, `chk19`, `chk20`, `chk21`) VALUES
(1, 29, '2013-12-03', '2013-12-03', 28, '我不覺得悲傷', '對將來我感到沮喪', '身為一個人我覺得我是徹底的失敗者', '與過去比較，現在我比較不能從事情中獲得喜悅', '相當多的時間我覺得罪惡', '我不認為我正受懲罰', '我討厭自己', '我因自己有弱點或錯誤而批評自己', '如果有機會我會自殺', '我並不比平常容易哭', '過去經常使我暴躁的事情一點也不再使我暴躁了', '我對他人並沒失去興趣', '我現在比以前更難做決定', '我煩惱自己看起來漸老或漸不吸引人了', '我需要特別努力，才能開始做事', '我不如以往睡得好', '我太累了以致無法做任何事', '我的胃口並不比前差', '我的體重減輕5磅(3.5公斤)以上', '我擔心我身體上的不舒服，諸如：頭痛及身體上的病痛、胃不舒服或便秘等', '我對於性完全失去興趣');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
