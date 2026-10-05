-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 20, 2026 at 12:18 PM
-- Server version: 8.4.7
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `logika_fuzzy`
--

-- --------------------------------------------------------

--
-- Table structure for table `kategori_usia`
--

DROP TABLE IF EXISTS `kategori_usia`;
CREATE TABLE IF NOT EXISTS `kategori_usia` (
  `id_kategori` int NOT NULL,
  `nama_kategori` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `domain_min` decimal(5,2) NOT NULL,
  `domain_max` decimal(5,2) NOT NULL,
  `a` decimal(5,2) NOT NULL,
  `b` decimal(5,2) NOT NULL,
  `c` decimal(5,2) NOT NULL,
  `d` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id_kategori`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kategori_usia`
--

INSERT INTO `kategori_usia` (`id_kategori`, `nama_kategori`, `domain_min`, `domain_max`, `a`, `b`, `c`, `d`) VALUES
(1, 'Bayi/Anak Usia Dini', 0.00, 5.00, 0.00, 1.25, 3.75, 5.00),
(2, 'Anak-anak', 6.00, 11.00, 6.00, 7.25, 9.75, 11.00),
(3, 'Remaja (Adolescent)', 10.00, 19.00, 10.00, 12.25, 16.75, 19.00),
(4, 'Pemuda (Youth)', 15.00, 24.00, 15.00, 17.25, 21.75, 24.00),
(5, 'Dewasa (Adult)', 20.00, 65.00, 20.00, 31.25, 53.75, 65.00),
(6, 'Lanjut Usia (Elderly/Lansia)', 65.00, 100.00, 65.00, 73.75, 91.25, 100.00);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
