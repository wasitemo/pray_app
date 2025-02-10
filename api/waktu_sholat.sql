-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 10, 2025 at 04:29 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `waktu_sholat`
--

-- --------------------------------------------------------

--
-- Table structure for table `jadwal_sholat`
--

CREATE TABLE `jadwal_sholat` (
  `id` int(11) NOT NULL,
  `lokasi` varchar(100) NOT NULL,
  `tanggal` date NOT NULL,
  `subuh` time NOT NULL,
  `dzuhur` time NOT NULL,
  `ashar` time NOT NULL,
  `maghrib` time NOT NULL,
  `isya` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jadwal_sholat`
--

INSERT INTO `jadwal_sholat` (`id`, `lokasi`, `tanggal`, `subuh`, `dzuhur`, `ashar`, `maghrib`, `isya`) VALUES
(1, 'Jakarta', '2025-02-10', '04:30:00', '12:10:00', '15:20:00', '18:00:00', '19:20:00'),
(2, 'Surabaya', '2025-02-10', '04:20:00', '12:00:00', '15:10:00', '17:50:00', '19:10:00'),
(3, 'Bandung', '2025-02-10', '04:25:00', '12:05:00', '15:15:00', '17:55:00', '19:15:00'),
(4, 'Banjarmasin', '2025-02-01', '05:09:00', '12:39:00', '15:59:00', '18:46:00', '19:58:00'),
(5, 'Banjarmasin', '2025-02-02', '05:10:00', '12:39:00', '15:59:00', '18:46:00', '19:57:00'),
(6, 'Banjarmasin', '2025-02-03', '05:10:00', '12:39:00', '15:59:00', '18:46:00', '19:57:00'),
(7, 'Banjarmasin', '2025-02-04', '05:10:00', '12:39:00', '15:58:00', '18:46:00', '19:57:00'),
(8, 'Banjarmasin', '2025-02-05', '05:10:00', '12:39:00', '15:58:00', '18:46:00', '19:57:00'),
(9, 'Banjarmasin', '2025-02-06', '05:11:00', '12:39:00', '15:58:00', '18:46:00', '19:57:00'),
(10, 'Banjarmasin', '2025-02-07', '05:11:00', '12:39:00', '15:58:00', '18:46:00', '19:57:00'),
(11, 'Banjarmasin', '2025-02-08', '05:11:00', '12:39:00', '15:57:00', '18:46:00', '19:57:00'),
(12, 'Banjarmasin', '2025-02-09', '05:12:00', '12:39:00', '15:57:00', '18:46:00', '19:57:00'),
(13, 'Banjarmasin', '2025-02-10', '05:12:00', '12:39:00', '15:57:00', '18:46:00', '19:56:00'),
(14, 'Banjarmasin', '2025-02-11', '05:12:00', '12:39:00', '15:56:00', '18:46:00', '19:56:00'),
(15, 'Banjarmasin', '2025-02-12', '05:12:00', '12:39:00', '15:56:00', '18:46:00', '19:56:00'),
(16, 'Banjarmasin', '2025-02-13', '05:12:00', '12:39:00', '15:55:00', '18:46:00', '19:56:00'),
(17, 'Banjarmasin', '2025-02-14', '05:13:00', '12:39:00', '15:55:00', '18:45:00', '19:55:00'),
(18, 'Banjarmasin', '2025-02-15', '05:13:00', '12:39:00', '15:54:00', '18:45:00', '19:55:00'),
(19, 'Banjarmasin', '2025-02-16', '05:13:00', '12:39:00', '15:54:00', '18:45:00', '19:55:00'),
(20, 'Banjarmasin', '2025-02-17', '05:13:00', '12:39:00', '15:53:00', '18:45:00', '19:55:00'),
(21, 'Banjarmasin', '2025-02-18', '05:13:00', '12:39:00', '15:53:00', '18:45:00', '19:54:00'),
(22, 'Banjarmasin', '2025-02-19', '05:13:00', '12:39:00', '15:52:00', '18:45:00', '19:54:00'),
(23, 'Banjarmasin', '2025-02-20', '05:13:00', '12:39:00', '15:51:00', '18:44:00', '19:54:00'),
(24, 'Banjarmasin', '2025-02-21', '05:13:00', '12:39:00', '15:51:00', '18:44:00', '19:54:00'),
(25, 'Banjarmasin', '2025-02-22', '05:14:00', '12:39:00', '15:50:00', '18:44:00', '19:53:00'),
(26, 'Banjarmasin', '2025-02-23', '05:14:00', '12:38:00', '15:49:00', '18:44:00', '19:53:00'),
(27, 'Banjarmasin', '2025-02-24', '05:14:00', '12:38:00', '15:49:00', '18:43:00', '19:53:00'),
(28, 'Banjarmasin', '2025-02-25', '05:14:00', '12:38:00', '15:48:00', '18:43:00', '19:52:00'),
(29, 'Banjarmasin', '2025-02-26', '05:14:00', '12:38:00', '15:47:00', '18:43:00', '19:52:00'),
(30, 'Banjarmasin', '2025-02-27', '05:14:00', '12:38:00', '15:46:00', '18:43:00', '19:52:00'),
(31, 'Banjarmasin', '2025-02-28', '05:14:00', '12:38:00', '15:46:00', '18:42:00', '19:51:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jadwal_sholat`
--
ALTER TABLE `jadwal_sholat`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `lokasi` (`lokasi`,`tanggal`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `jadwal_sholat`
--
ALTER TABLE `jadwal_sholat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
