-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 14, 2019 at 10:40 AM
-- Server version: 10.1.34-MariaDB
-- PHP Version: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fps`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbladmin`
--

CREATE TABLE `tbladmin` (
  `pkcanteen_id` int(10) NOT NULL,
  `canteen_name` varchar(50) NOT NULL,
  `admin_name` varchar(30) NOT NULL,
  `password` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_number` int(10) NOT NULL,
  `address` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbladmin`
--

INSERT INTO `tbladmin` (`pkcanteen_id`, `canteen_name`, `admin_name`, `password`, `email`, `phone_number`, `address`) VALUES
(1, 'V.V.P. Engineering College', 'sahil', '12345', 'sahil@gmail.com', 1234512345, 'Kalawad Road, Rajkot.');

-- --------------------------------------------------------

--
-- Table structure for table `tblmenu`
--

CREATE TABLE `tblmenu` (
  `pkmenu` int(10) NOT NULL,
  `fkcanteen_id` int(10) NOT NULL,
  `food_name` varchar(30) NOT NULL,
  `price` int(10) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `category` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblmenu`
--

INSERT INTO `tblmenu` (`pkmenu`, `fkcanteen_id`, `food_name`, `price`, `status`, `category`) VALUES
(1, 1, 'Plain Dosa', 50, 1, 'South Indian'),
(2, 1, 'Manchurian Dry', 100, 0, 'Chinese'),
(3, 1, 'Paneer Toofani', 250, 0, 'Punjabi'),
(4, 1, 'Masala Dosa', 100, 0, 'South Indian'),
(5, 1, 'Noodles', 120, 0, 'Chinese');

-- --------------------------------------------------------

--
-- Table structure for table `tblorder`
--

CREATE TABLE `tblorder` (
  `pkorder_id` int(10) NOT NULL,
  `fkuser_id` int(10) NOT NULL,
  `fkcanteen_id` int(10) NOT NULL,
  `total_item` int(3) NOT NULL,
  `dateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `delivery_time` time NOT NULL DEFAULT '00:00:00',
  `payment_type` varchar(20) NOT NULL,
  `ref_menu` varchar(30) NOT NULL,
  `status` varchar(30) NOT NULL,
  `quantity` varchar(30) NOT NULL,
  `price` varchar(30) NOT NULL,
  `total_price` int(11) NOT NULL,
  `remark` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblorder`
--

INSERT INTO `tblorder` (`pkorder_id`, `fkuser_id`, `fkcanteen_id`, `total_item`, `dateTime`, `delivery_time`, `payment_type`, `ref_menu`, `status`, `quantity`, `price`, `total_price`, `remark`) VALUES
(1, 1, 1, 3, '2019-09-24 10:00:42', '08:00:00', 'Wallet', '3,2,1,', 'yet to be delivered', '1,1,1,', '250,100,50,', 400, ''),
(2, 3, 1, 3, '2019-09-24 23:13:14', '11:30:00', 'Wallet', '3,2,1,', 'yet to be delivered', '1,1,1,', '250,100,50,', 400, ''),
(3, 3, 1, 3, '2019-09-24 23:14:44', '11:30:00', 'Wallet', '3,2,1,', 'yet to be delivered', '1,1,1,', '250,100,50,', 400, ''),
(4, 3, 1, 3, '2019-09-24 23:14:53', '11:30:00', 'Wallet', '3,2,1,', 'yet to be delivered', '1,1,1,', '250,100,50,', 400, ''),
(5, 3, 1, 3, '2019-09-24 23:15:00', '11:30:00', 'Wallet', '3,2,1,', 'yet to be delivered', '1,1,1,', '250,100,50,', 400, ''),
(6, 3, 1, 3, '2019-09-24 23:15:19', '11:30:00', 'Wallet', '3,2,1,', 'yet to be delivered', '1,1,1,', '250,100,50,', 400, ''),
(7, 3, 1, 3, '2019-09-24 23:15:28', '11:30:00', 'Cash On Delivery', '3,2,1,', 'cancelled by customer', '1,1,1,', '250,100,50,', 400, ''),
(8, 3, 1, 3, '2019-09-24 23:19:02', '11:30:00', 'Cash On Delivery', '3,2,1,', 'yet to be delivered', '1,1,1,', '250,100,50,', 400, ''),
(9, 3, 1, 3, '2019-09-24 23:19:57', '11:30:00', 'Wallet', '3,2,1,', 'yet to be delivered', '1,1,1,', '250,100,50,', 400, ''),
(10, 3, 1, 2, '2019-09-24 23:50:09', '11:30:00', 'Cash On Delivery', '5,4,', 'yet to be delivered', '1,1,', '120,100,', 220, ''),
(11, 3, 1, 2, '2019-09-24 23:50:40', '11:30:00', 'Cash On Delivery', '5,4,', 'yet to be delivered', '1,1,', '120,100,', 220, ''),
(12, 3, 1, 2, '2019-09-24 23:50:54', '11:30:00', 'Cash On Delivery', '5,4,', 'cancelled by customer', '1,1,', '120,100,', 220, ''),
(13, 3, 1, 2, '2019-09-24 23:51:11', '11:30:00', 'Cash On Delivery', '5,4,', 'yet to be delivered', '1,1,', '120,100,', 220, ''),
(14, 3, 1, 2, '2019-09-24 23:52:23', '11:30:00', 'Cash On Delivery', '5,4,', 'yet to be delivered', '1,1,', '120,100,', 220, ''),
(15, 3, 1, 2, '2019-09-24 23:53:16', '11:30:00', 'Cash On Delivery', '5,4,', 'yet to be delivered', '1,1,', '120,100,', 220, ''),
(16, 3, 1, 2, '2019-09-24 23:53:28', '11:30:00', 'Cash On Delivery', '5,4,', 'yet to be delivered', '1,1,', '120,100,', 220, ''),
(17, 3, 1, 2, '2019-09-24 23:54:21', '11:30:00', 'Cash On Delivery', '5,4,', 'yet to be delivered', '1,1,', '120,100,', 220, ''),
(18, 3, 1, 2, '2019-09-24 23:54:25', '11:30:00', 'Cash On Delivery', '5,4,', 'yet to be delivered', '1,1,', '120,100,', 220, ''),
(19, 3, 1, 2, '2019-09-24 23:55:50', '11:30:00', 'Cash On Delivery', '4,1,', 'yet to be delivered', '1,2,', '100,50,', 200, ''),
(20, 3, 1, 2, '2019-09-24 23:56:35', '11:30:00', 'Cash On Delivery', '4,1,', 'yet to be delivered', '1,2,', '100,50,', 200, ''),
(21, 3, 1, 2, '2019-09-24 23:57:37', '11:30:00', 'Cash On Delivery', '5,2,', 'cancelled by customer', '1,2,', '120,100,', 320, ''),
(22, 3, 1, 2, '2019-09-25 00:04:04', '11:30:00', 'Cash On Delivery', '5,2,', 'yet to be delivered', '1,2,', '120,100,', 320, ''),
(23, 3, 1, 2, '2019-09-25 00:29:26', '11:30:00', 'Cash On Delivery', '5,2,', 'yet to be delivered', '1,2,', '120,100,', 320, ''),
(24, 3, 1, 2, '2019-09-25 00:33:45', '11:30:00', 'Wallet', '3,4,', 'yet to be delivered', '2,2,', '250,100,', 700, ''),
(25, 3, 1, 2, '2019-09-25 00:36:17', '11:30:00', 'Wallet', '3,4,', 'yet to be delivered', '2,2,', '250,100,', 700, ''),
(26, 3, 1, 2, '2019-09-25 00:37:26', '11:30:00', 'Wallet', '3,4,', 'yet to be delivered', '2,2,', '250,100,', 700, ''),
(27, 3, 1, 2, '2019-09-25 00:45:06', '11:30:00', 'Wallet', '5,2,', 'yet to be delivered', '1,2,', '120,100,', 320, ''),
(28, 3, 1, 2, '2019-09-25 00:45:18', '11:30:00', 'Cash On Delivery', '5,2,', 'yet to be delivered', '1,2,', '120,100,', 320, ''),
(29, 3, 1, 2, '2019-09-25 00:45:25', '11:30:00', 'Cash On Delivery', '5,2,', 'yet to be delivered', '1,2,', '120,100,', 320, ''),
(30, 3, 1, 2, '2019-09-25 00:45:38', '11:30:00', 'Cash On Delivery', '5,2,', 'yet to be delivered', '1,2,', '120,100,', 320, '');

-- --------------------------------------------------------

--
-- Table structure for table `tbluser`
--

CREATE TABLE `tbluser` (
  `pkuser_id` int(10) NOT NULL,
  `username` varchar(10) NOT NULL,
  `first_name` varchar(10) NOT NULL,
  `last_name` varchar(10) NOT NULL,
  `password` varchar(10) NOT NULL,
  `balance` int(5) NOT NULL DEFAULT '0',
  `phone_number` varchar(10) NOT NULL,
  `email` varchar(40) NOT NULL,
  `fkcanteen_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbluser`
--

INSERT INTO `tbluser` (`pkuser_id`, `username`, `first_name`, `last_name`, `password`, `balance`, `phone_number`, `email`, `fkcanteen_id`) VALUES
(1, 'amarpatel', 'Amar', 'Patel', '12345', 1000, '1231112311', 'amarpatel@gmail.com', 'V.V.P. Engineering College'),
(2, 'samarpatel', 'Samar', 'Patel', '12345', 750, '1234567890', 'samarpatel@gmail.com', 'V.V.P. Engineering College'),
(3, 'savanpatel', 'Savan', 'Patel', '12345', 1420, '1112221112', 'savanpatel@gmail.com', 'V.V.P. Engineering College');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbladmin`
--
ALTER TABLE `tbladmin`
  ADD PRIMARY KEY (`pkcanteen_id`),
  ADD UNIQUE KEY `admin_name` (`admin_name`);

--
-- Indexes for table `tblmenu`
--
ALTER TABLE `tblmenu`
  ADD PRIMARY KEY (`pkmenu`),
  ADD KEY `fkcanteen_id` (`fkcanteen_id`);

--
-- Indexes for table `tblorder`
--
ALTER TABLE `tblorder`
  ADD PRIMARY KEY (`pkorder_id`),
  ADD KEY `fkuser_id` (`fkuser_id`),
  ADD KEY `fkcanteen_id` (`fkcanteen_id`);

--
-- Indexes for table `tbluser`
--
ALTER TABLE `tbluser`
  ADD PRIMARY KEY (`pkuser_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbladmin`
--
ALTER TABLE `tbladmin`
  MODIFY `pkcanteen_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblmenu`
--
ALTER TABLE `tblmenu`
  MODIFY `pkmenu` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tblorder`
--
ALTER TABLE `tblorder`
  MODIFY `pkorder_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `tbluser`
--
ALTER TABLE `tbluser`
  MODIFY `pkuser_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tblmenu`
--
ALTER TABLE `tblmenu`
  ADD CONSTRAINT `tblmenu_ibfk_1` FOREIGN KEY (`fkcanteen_id`) REFERENCES `tbladmin` (`pkcanteen_id`) ON DELETE CASCADE;

--
-- Constraints for table `tblorder`
--
ALTER TABLE `tblorder`
  ADD CONSTRAINT `tblorder_ibfk_1` FOREIGN KEY (`fkuser_id`) REFERENCES `tbluser` (`pkuser_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tblorder_ibfk_2` FOREIGN KEY (`fkcanteen_id`) REFERENCES `tbladmin` (`pkcanteen_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
