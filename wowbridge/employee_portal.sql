-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 25, 2019 at 04:28 PM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 7.0.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `employee_portal`
--

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `task`
--

CREATE TABLE `task` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `jira_issue_id` int(11) NOT NULL,
  `issue_type` varchar(20) NOT NULL COMMENT 'Task, Bug',
  `module` varchar(200) NOT NULL,
  `component` varchar(50) NOT NULL,
  `summary` text NOT NULL,
  `description` text NOT NULL,
  `actor` varchar(50) NOT NULL COMMENT 'User Type',
  `complexity` varchar(20) NOT NULL,
  `priority` varchar(20) NOT NULL COMMENT 'Highest,High,Medium,Low,Lowest',
  `estimate` time NOT NULL,
  `planned_start_date` date NOT NULL,
  `planned_end_date` date NOT NULL,
  `status` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `task_log`
--

CREATE TABLE `task_log` (
  `id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL,
  `file_name` text NOT NULL,
  `class_name` varchar(255) NOT NULL COMMENT 'Controller,Component,Action',
  `function_name` varchar(255) NOT NULL,
  `model_name` varchar(255) NOT NULL,
  `database_table_name` varchar(255) NOT NULL,
  `view_name` varchar(255) NOT NULL COMMENT 'Template',
  `resolution` varchar(50) NOT NULL COMMENT 'In-progress, QA,Pending,Done,',
  `status` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `test_case`
--

CREATE TABLE `test_case` (
  `id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `test_case_id` varchar(50) NOT NULL,
  `test_condition` text NOT NULL,
  `expected_result` text NOT NULL,
  `approved_status` varchar(10) NOT NULL,
  `approved_by` int(11) NOT NULL,
  `review` tinyint(2) NOT NULL,
  `comments` text NOT NULL,
  `status` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `test_run`
--

CREATE TABLE `test_run` (
  `id` bigint(20) NOT NULL,
  `test_case_id` bigint(20) NOT NULL,
  `actual_result` text NOT NULL,
  `test_run_status` varchar(20) NOT NULL,
  `severity` varchar(10) NOT NULL,
  `bug_id` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `task`
--
ALTER TABLE `task`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `task_log`
--
ALTER TABLE `task_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_id` (`task_id`);

--
-- Indexes for table `test_case`
--
ALTER TABLE `test_case`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_id` (`task_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `test_run`
--
ALTER TABLE `test_run`
  ADD PRIMARY KEY (`id`),
  ADD KEY `test_case_id` (`test_case_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `task`
--
ALTER TABLE `task`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `task_log`
--
ALTER TABLE `task_log`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `test_case`
--
ALTER TABLE `test_case`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `test_run`
--
ALTER TABLE `test_run`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `task`
--
ALTER TABLE `task`
  ADD CONSTRAINT `task_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `task_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`);

--
-- Constraints for table `task_log`
--
ALTER TABLE `task_log`
  ADD CONSTRAINT `task_log_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`);

--
-- Constraints for table `test_case`
--
ALTER TABLE `test_case`
  ADD CONSTRAINT `test_case_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`),
  ADD CONSTRAINT `test_case_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `test_run`
--
ALTER TABLE `test_run`
  ADD CONSTRAINT `test_run_ibfk_1` FOREIGN KEY (`test_case_id`) REFERENCES `test_case` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
