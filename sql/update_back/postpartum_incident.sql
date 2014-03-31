-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 建立日期: 2014 年 01 月 17 日 09:11
-- 伺服器版本: 5.5.25a
-- PHP 版本: 5.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 資料庫: `postpartum_doreen`
--

-- --------------------------------------------------------

--
-- 資料表結構 `incident`
--

CREATE TABLE IF NOT EXISTS `incident` (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `news_category_id` int(11) NOT NULL,
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_bin NOT NULL,
  `description` text COLLATE utf8_bin NOT NULL,
  `comment` text COLLATE utf8_bin NOT NULL,
  `count_read` int(11) NOT NULL DEFAULT '0',
  `allow_comment` int(1) NOT NULL DEFAULT '1',
  `comment_permission` int(1) NOT NULL DEFAULT '0',
  `comment_need_approval` int(1) NOT NULL DEFAULT '0',
  `sort_order` int(3) NOT NULL DEFAULT '0',
  `status` int(1) NOT NULL DEFAULT '1',
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`news_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

--
-- 資料表的匯出資料 `incident`
--

INSERT INTO `incident` (`news_id`, `news_category_id`, `image`, `title`, `description`, `comment`, `count_read`, `allow_comment`, `comment_permission`, `comment_need_approval`, `sort_order`, `status`, `date_added`, `date_modified`, `user_id`) VALUES
(1, 6, NULL, '', 0x727272727272, 0x676767, 0, 1, 0, 0, 0, 0, '2014-01-17 08:40:10', '2014-01-17 08:40:10', 22);

-- --------------------------------------------------------

--
-- 資料表結構 `incident_category`
--

CREATE TABLE IF NOT EXISTS `incident_category` (
  `news_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_bin NOT NULL,
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `textcolor` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `sort_order` int(3) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`news_category_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=9 ;

--
-- 資料表的匯出資料 `incident_category`
--

INSERT INTO `incident_category` (`news_category_id`, `name`, `image`, `textcolor`, `sort_order`, `status`, `date_added`, `date_modified`) VALUES
(1, '自殺', '', '#b851b3', 2, 1, '2012-12-17 15:36:49', '2014-01-16 14:59:04'),
(3, '財物失竊', '', '', 3, 1, '2013-09-05 09:54:58', '2014-01-16 15:00:03'),
(4, '燙傷', '', '', 1, 1, '2013-09-05 09:55:23', '2014-01-16 14:58:53'),
(6, '跌倒或暈倒', '', '#f01313', 0, 1, '2013-10-30 20:44:36', '2014-01-16 14:58:42'),
(7, '暴力事件', NULL, '', 4, 1, '2014-01-16 15:01:28', '2014-01-16 15:01:28'),
(8, '火災', NULL, '', 5, 1, '2014-01-16 15:01:42', '2014-01-16 15:01:42');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
