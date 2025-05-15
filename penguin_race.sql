-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 08, 2025 at 08:54 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `penguin_race`
--

-- --------------------------------------------------------

--
-- Table structure for table `bet_history`
--

CREATE TABLE `bet_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `penguin_selected` varchar(10) DEFAULT NULL,
  `bet_amount` decimal(10,2) DEFAULT NULL,
  `outcome` varchar(10) DEFAULT NULL,
  `winnings` decimal(10,2) DEFAULT NULL,
  `race_time` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bet_history`
--

INSERT INTO `bet_history` (`id`, `user_id`, `penguin_selected`, `bet_amount`, `outcome`, `winnings`, `race_time`) VALUES
(1, 2, 'p1', 200.00, 'lose', 0.00, '2025-04-26 10:11:21'),
(2, 1, 'p3', 90.00, 'lose', 0.00, '2025-04-26 10:20:55'),
(3, 1, 'p2', 100.00, 'win', 200.00, '2025-04-26 10:24:46'),
(4, 1, 'p3', 100.00, 'lose', 0.00, '2025-04-26 11:35:32'),
(5, 1, 'p3', 100.00, 'lose', 0.00, '2025-04-26 11:36:47'),
(6, 1, 'p3', 100.00, 'lose', 0.00, '2025-04-26 11:36:53'),
(7, 2, 'p3', 500.00, 'lose', 0.00, '2025-04-26 11:38:53'),
(8, 2, 'p3', 500.00, 'lose', 0.00, '2025-04-26 11:39:01'),
(9, 2, 'p3', 500.00, 'lose', 0.00, '2025-04-26 11:39:07'),
(10, 2, 'p3', 500.00, 'lose', 0.00, '2025-04-26 11:39:13'),
(11, 2, 'p3', 800.00, 'lose', 0.00, '2025-04-26 11:39:24'),
(12, 2, 'p3', 800.00, 'lose', 0.00, '2025-04-26 11:39:30'),
(13, 2, 'p1', 800.00, 'lose', 0.00, '2025-04-26 11:39:39'),
(14, 2, 'p1', 800.00, 'lose', 0.00, '2025-04-26 11:39:45'),
(15, 2, 'p1', 800.00, 'lose', 0.00, '2025-04-26 11:39:51'),
(16, 2, 'p5', 800.00, 'win', 1600.00, '2025-04-26 11:40:00'),
(17, 2, 'p2', 4000.00, 'lose', 0.00, '2025-04-26 11:40:18'),
(18, 2, 'p2', 200.00, 'lose', 0.00, '2025-04-26 11:43:38'),
(19, 2, 'p4', 200.00, 'lose', 0.00, '2025-04-26 11:43:49'),
(20, 2, 'p1', 100.00, 'lose', 0.00, '2025-04-27 21:16:44'),
(21, 2, 'p4', 500.00, 'lose', 0.00, '2025-04-27 21:20:28'),
(22, 4, 'p3', 500.00, 'lose', 0.00, '2025-04-27 21:23:38'),
(23, 4, 'p3', 500.00, 'win', 1000.00, '2025-04-27 21:27:21'),
(24, 4, 'p4', 1000.00, 'lose', 0.00, '2025-04-27 21:27:41');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `balance`, `created_at`) VALUES
(2, 'Juan', '$2y$10$rJAidZSfTdGlDgBApUlDEO2q5TV2gGkYZ1ItwQTnz13HCdda1oPhe', 500.00, '2025-04-25 17:13:11'),
(3, 'John', '$2y$10$B7pBV8Bb6Cv0t6Xn7jzXtuTl2KBNWATQdhIp6c2z34woVTx3wIDi.', 0.00, '2025-04-26 03:33:56'),
(4, 'Stanley', '$2y$10$O9aiwzwImEezUTPXRFELqulX.jXVx5plUqTZGKkjdVW/hSbQ7KJ4.', 0.00, '2025-04-27 13:21:35'),
(5, 'cj', '$2y$10$cujY5pJOgLVs3MoOMxiU5ewORENaxc6XBIssNaqZ2xgbDtl9oJSd6', 0.00, '2025-05-08 06:39:19'),
(6, 'jeff', '$2y$10$QWgJGZtgE32WeqtCgo2Ufu.fcSxL9n91lDaBnR7ES32OO32A2jKJ2', 0.00, '2025-05-08 06:49:08');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bet_history`
--
ALTER TABLE `bet_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bet_history`
--
ALTER TABLE `bet_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
