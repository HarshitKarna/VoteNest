-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 26, 2026 at 12:12 PM
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
-- Database: `901_votingproj`
--

-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE `options` (
  `id` int(11) NOT NULL,
  `poll_code` varchar(8) NOT NULL,
  `option_text` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_disqualified` tinyint(1) NOT NULL DEFAULT 0,
  `disqualify_reason` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`id`, `poll_code`, `option_text`, `description`, `is_disqualified`, `disqualify_reason`) VALUES
(13, '59392181', 'C/C++', 'Cause it is the mother of all programming languages.', 0, NULL),
(14, '59392181', 'Python', 'Usable in EVERY SINGLE FIELD', 0, NULL),
(15, '59392181', 'HTML/CSS', 'Responsible for all websites we see everyday', 1, 'BECAUSE I CAN YEAH'),
(16, '09183115', 'Apple', '', 0, NULL),
(17, '09183115', 'Mango', '', 0, NULL),
(18, '09183115', 'Banana', '', 0, NULL),
(19, '09183115', 'Guava', '', 0, NULL),
(20, '09183115', 'Grapes', '', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `polls`
--

CREATE TABLE `polls` (
  `id` int(11) NOT NULL,
  `code` varchar(8) NOT NULL,
  `title` varchar(255) NOT NULL,
  `question` text NOT NULL,
  `creator_email` varchar(255) NOT NULL,
  `show_results` tinyint(1) NOT NULL DEFAULT 0,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `end_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `polls`
--

INSERT INTO `polls` (`id`, `code`, `title`, `question`, `creator_email`, `show_results`, `status`, `created_at`, `end_time`) VALUES
(4, '59392181', 'Popular Programming Language', 'What is your most favourite programming language', '024neb901@sxc.edu.np', 1, 'ended', '2026-03-07 13:56:35', '2026-03-07 20:41:35'),
(5, '09183115', 'Best Fruit', 'What is your most favourite fruit?', 'harshitkarna64@gmail.com', 0, 'ended', '2026-03-07 13:59:32', '2026-03-07 21:04:32');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_master_admin` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `is_master_admin`, `created_at`) VALUES
(1, 'harshitkarna64@gmail.com', '$2y$12$Yql5j2n3P48NkBaIFLBiYecmufOvinxAYQGNLjmZss19dgoFUI3rq', 0, '2026-03-07 07:31:51'),
(2, 'emailistakenidc@gmail.com', '$2y$12$HfxKJmyEZbgVbeDRIUyawuzIwcXIjm7NhJb.GkpMwJ58S.Pr.fgI2', 0, '2026-03-07 07:31:51'),
(3, '024neb901@sxc.edu.np', '$2y$12$wLoJTodC1kha9oOD.VSVh.KmlHddPbxsOyhUmYPmhES9wPvIz62wG', 1, '2026-03-07 07:31:51');

-- --------------------------------------------------------

--
-- Table structure for table `votes`
--

CREATE TABLE `votes` (
  `id` int(11) NOT NULL,
  `poll_code` varchar(8) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `option_id` int(11) NOT NULL,
  `voted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `votes`
--

INSERT INTO `votes` (`id`, `poll_code`, `user_email`, `option_id`, `voted_at`) VALUES
(2, '59392181', '024neb901@sxc.edu.np', 14, '2026-03-07 14:10:43'),
(3, '59392181', 'emailistakenidc@gmail.com', 14, '2026-03-07 14:12:41'),
(4, '09183115', 'emailistakenidc@gmail.com', 17, '2026-03-07 14:12:49'),
(5, '09183115', 'harshitkarna64@gmail.com', 17, '2026-03-07 14:13:10'),
(7, '09183115', '024neb901@sxc.edu.np', 16, '2026-03-07 14:14:25');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_poll_code` (`poll_code`);

--
-- Indexes for table `polls`
--
ALTER TABLE `polls`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `creator_email` (`creator_email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `votes`
--
ALTER TABLE `votes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_vote` (`poll_code`,`user_email`),
  ADD KEY `user_email` (`user_email`),
  ADD KEY `option_id` (`option_id`),
  ADD KEY `idx_poll_code` (`poll_code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `polls`
--
ALTER TABLE `polls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `votes`
--
ALTER TABLE `votes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `options`
--
ALTER TABLE `options`
  ADD CONSTRAINT `options_ibfk_1` FOREIGN KEY (`poll_code`) REFERENCES `polls` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `polls`
--
ALTER TABLE `polls`
  ADD CONSTRAINT `polls_ibfk_1` FOREIGN KEY (`creator_email`) REFERENCES `users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `votes`
--
ALTER TABLE `votes`
  ADD CONSTRAINT `votes_ibfk_1` FOREIGN KEY (`poll_code`) REFERENCES `polls` (`code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `votes_ibfk_2` FOREIGN KEY (`user_email`) REFERENCES `users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `votes_ibfk_3` FOREIGN KEY (`option_id`) REFERENCES `options` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
