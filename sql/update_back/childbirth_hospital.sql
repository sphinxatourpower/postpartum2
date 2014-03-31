-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 建立日期: 2013 年 12 月 04 日 16:50
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
-- 資料表結構 `childbirth_hospital`
--

CREATE TABLE IF NOT EXISTS `childbirth_hospital` (
  `childbirth_hospital_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`childbirth_hospital_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 資料表的匯出資料 `childbirth_hospital`
--

INSERT INTO `childbirth_hospital` (`childbirth_hospital_id`, `name`, `sort_order`) VALUES
(1, '羅東聖母醫院', 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
