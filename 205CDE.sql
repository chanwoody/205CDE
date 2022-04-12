-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 12, 2022 at 11:06 AM
-- Server version: 8.0.28-0ubuntu0.20.04.3
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `205CDE`
--

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `introduce` varchar(200) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `available_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `userid` int NOT NULL,
  `shopid` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `product_name`, `introduce`, `price`, `available_date`, `userid`, `shopid`) VALUES
(30, 'apple', 'It is yummy', '10.00', '2022-04-10 15:10:09', 5, 2),
(31, 'apple', 'It is yummy', '5.00', '2022-04-10 15:23:29', 4, 3),
(32, 'orange', 'It is a orange come from japan', '20.99', '2022-04-10 19:21:04', 4, 2),
(33, '222', 'werwerwgfdfgdhjffweuhjirjuawejurwajuiejuifjwajduifjiuadsjuifjuiawe', '1999999.00', '2022-04-10 19:22:48', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `shop`
--

CREATE TABLE `shop` (
  `id` int NOT NULL,
  `shopname` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `shop`
--

INSERT INTO `shop` (`id`, `shopname`, `address`) VALUES
(1, 'Yuen Long Shop', 'Yuen Long,Yuen Long,Hong Kong'),
(2, 'Sha Tin Shop', 'Sha Tin,Sha Tin,Hong Kong'),
(3, 'Kowloon Tong', 'Cityu, Kowloon Tong');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `register_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `username`, `password`, `register_date`) VALUES
(4, 'Woody Chan', 'woodychan', 'woody', '$5$rounds=535000$hIWycYb3pdXnNRO3$pr21M1MnhvzQ1EkZcs1oyDAcV02Xv3a4qP7DJcf9lo6', '2022-04-09 16:49:03'),
(5, 'billy cheung', 'billycheung@gmail.com', 'billycheung', '$5$rounds=535000$Edx/WlOX6n1ebc1B$P8Hg7ebDR8BH326XB9ea8MnHEu7ZvYzIvN.Mt7Hpgu9', '2022-04-10 07:05:52'),
(6, 'Sandy Tong', 'sandytong@gmail.com', 'sandytong3', '$5$rounds=535000$9lCy6ZULSz/YkX9G$1KK3TN2897DtmYvcMNenC/dcDXjlVAaOWJPz3WG2l86', '2022-04-10 11:23:39'),
(7, '123', '123456', '1234', '$5$rounds=535000$qZc8XY9QOZHaBUQv$cWkee1PdJFy4HsEAX/CLtZ.lxD8L0kElvM7S9T6z2f5', '2022-04-10 11:26:03'),
(8, 'asdf', 'asdfgh', 'asdf', '$5$rounds=535000$kOcwbdu2dskKrpso$K3s5gI/0gLjwmuXT87Isfxsoso42SSsvbGqjNyiChV2', '2022-04-10 11:29:03'),
(9, 'asdf', 'asdfgh', 'asdf', '$5$rounds=535000$K0Z6/LeiXjMYXFBP$sBFXqquhXTkgVHJo5hGYD2yTvPnYe5/hgNl2eaGkit1', '2022-04-10 11:31:09'),
(10, '567', 'uifefe', 'qwert', '$5$rounds=535000$jHOflLAsjlkMu75e$xV2N5x2xky.0F5YpYUKq9Dui1jXnTufujLQcj.gXlB5', '2022-04-10 11:38:36'),
(11, '54321', '543210', '54321', '$5$rounds=535000$XOVaXO1QeRAtPr.u$f68dinNT6DIOEPJ51dsMjQNkjG4Sxs64HyBFKHNmT79', '2022-04-10 11:42:46'),
(25, 'test', 'dbtest', 'test', '$5$rounds=535000$2y75LIJpe3ovVyYf$8NtP/ewRx.8EZ8IIfXJovE2ylltStT478VNn1sHtXBD', '2022-04-11 13:16:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`),
  ADD KEY `shopid` (`shopid`);

--
-- Indexes for table `shop`
--
ALTER TABLE `shop`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `shop`
--
ALTER TABLE `shop`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`shopid`) REFERENCES `shop` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
