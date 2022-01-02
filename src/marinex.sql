-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Värd: 127.0.0.1
-- Tid vid skapande: 17 dec 2021 kl 08:59
-- Serverversion: 10.4.21-MariaDB
-- PHP-version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databas: `marinex`
--

-- --------------------------------------------------------

--
-- Tabellstruktur `chart`
--

CREATE TABLE `chart` (
  `id` int(11) NOT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Completion` varchar(255) DEFAULT NULL,
  `Deadline` varchar(255) DEFAULT NULL,
  `Author` varchar(255) DEFAULT NULL,
  `Date` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumpning av Data i tabell `chart`
--

INSERT INTO `chart` (`id`, `Title`, `Completion`, `Deadline`, `Author`, `Date`) VALUES
(5, 'JAE', '79', '2021-12-23', 'Khalid', '2021-12-31'),
(6, 'JAE', '53', '2021-12-23', 'Khalid', '2021-12-31'),
(7, 'JAE', '66', '2021-12-23', 'Khalid', '2021-12-31'),
(8, 'JAE', '90', '2021-12-23', 'Khalid', '2021-12-31'),
(9, 'JAE', '84', '2021-12-23', 'Khalid', '2021-12-31'),
(10, 'JAE', '25', '2021-12-23', 'Khalid', '2021-12-31'),
(11, 'JBK', '0', '2022-01-08', 'Khalid', '2022-01-02'),
(12, 'JBK', '17', '2022-01-08', 'Khalid', '2022-01-02'),
(13, 'JBK', '52', '2022-01-08', 'Khalid', '2022-01-02'),
(14, 'JBK', '85', '2022-01-08', 'Khalid', '2022-01-02'),
(15, 'JBK', '100', '2022-01-08', 'Khalid', '2022-01-02'),
(16, 'OKE', '0', '2022-01-08', 'Khalid', '2022-01-08'),
(17, 'OKE', '0', '2022-02-06', 'Khalid', '2022-01-08'),
(18, 'JAE', '0', '2022-01-09', 'Khalid', '2021-12-31'),
(19, 'JAE', '34', '2022-01-09', 'Khalid', '2021-12-31'),
(20, 'OKE', '63', '2022-02-06', 'Khalid', '2022-01-08'),
(21, 'JBK', '27', '2021-12-06', 'Khalid', '2021-12-05'),
(22, 'Geee', '47', '2021-12-12', 'Khalid', '2021-12-05'),
(23, 'Okeee', '39', '2021-12-07', 'Khalid', '2021-12-04'),
(24, 'Okeee', '0', '2021-12-06', 'Khalid', '2021-12-04'),
(25, 'Okeee', '0', '2021-12-05', 'Khalid', '2021-12-04'),
(26, 'CSS', '20', '2022-01-02', 'Khalid', '2021-12-12'),
(27, 'Okeee', '78', '2021-12-05', 'Khalid', '2021-12-04'),
(28, 'okok', '73', '2022-01-07', 'Khalid', '2021-12-25'),
(29, 'okok', '0', '2021-12-31', 'Khalid', '2021-12-25'),
(30, 'okok', '0', '2022-01-09', 'Khalid', '2021-12-25'),
(31, 'HTML', '37', '2022-01-01', 'Khalid', '2021-12-05'),
(32, 'Skjutsa mama', '100', '2021-12-06', 'Khalid', '2021-12-05'),
(33, 'JBK', '58', '2021-12-06', 'Khalid', '2021-12-05'),
(34, 'CSS', '52', '2022-01-02', 'Khalid', '2021-12-12'),
(35, 'Okeee', '0', '2021-12-05', 'Khalid', '2021-12-04'),
(36, 'Okeee', '67', '2021-12-05', 'Khalid', '2021-12-04'),
(37, 'Okeee', '0', '2021-12-05', 'Khalid', '2021-12-04'),
(38, 'Okeee', '47', '2021-12-05', 'Khalid', '2021-12-04'),
(39, 'JBK', '100', '2021-12-06', 'Khalid', '2021-12-05'),
(40, 'JBK', '100', '2021-12-06', 'Khalid', '2021-12-05'),
(41, 'Meme', '43', '2021-12-11', 'Khalid', '2021-12-05'),
(42, 'JBK', '70', '2021-12-23', 'Khalid', '2021-12-31'),
(43, 'Morad', '34', '2021-12-31', 'Khalid', '2021-12-05'),
(44, 'JBK', '48', '2021-12-30', 'Khalid', '2021-12-05'),
(45, 'Morad', '0', '2021-12-31', 'Khalid', '2021-12-05'),
(46, 'ME', '41', '2021-12-31', 'Khalid', '2021-12-05'),
(47, 'efaf', '50', '2022-01-09', 'Khalid', '2021-12-05'),
(48, 'Morad', '60', '2022-01-09', 'Khalid', '2022-01-08'),
(49, 'okok', '0', '2022-12-06', 'Khalid', '2022-01-05'),
(50, 'aoemtåaoem', '49', '2022-12-06', 'Khalid', '2022-12-05'),
(51, 'JBK', '100', '2021-12-27', 'Khalid', '2021-12-06'),
(52, 'Medlife', '26', '2021-12-13', 'Khalid', '2021-12-06'),
(53, 'OK', '40', '2021-12-13', 'Khalid', '2021-12-06'),
(54, 'YO!', '55', '2021-12-09', 'Philip', '2021-12-06'),
(55, 'Test', '0', '2021-12-20', 'Anders', '2021-12-06'),
(56, 'Skolarbete Religion', '35', '2021-12-11', 'Khalid', '2021-12-08'),
(57, 'ff', '37', '2021-12-30', 'Khalid', '2021-12-14'),
(58, 'egea', '84', '2021-12-30', 'Khalid', '2021-12-17'),
(59, 'Mansaf', '31', '2021-12-16', 'Khalid', '2021-12-15'),
(60, 'Medlife', '100', '2021-12-13', 'Khalid', '2021-12-06'),
(61, 'Mansaf', '77', '2021-12-16', 'Khalid', '2021-12-15'),
(62, 'Mansaf', '81', '2021-12-16', 'Khalid', '2021-12-15'),
(63, 'ok', '55', '2021-12-30', 'Khalid', '2021-12-15'),
(64, 'JBK', 'undefined', 'undefined', 'undefined', 'undefined'),
(65, 'Medlife', '0', '2021-12-13', 'Khalid', '2021-12-06'),
(66, 'Medlife', '100', '2021-12-13', 'Khalid', '2021-12-06'),
(67, 'JBK', '0', '2021-12-27', 'Khalid', '2021-12-06'),
(68, 'JBK', '100', '2021-12-27', 'Khalid', '2021-12-06'),
(69, 'ookok', '21', '2021-12-18', 'Khalid', '2021-12-17'),
(70, 'aa', '37', '2021-12-19', 'Khalid', '2021-12-17'),
(71, 'sgsg', '0', '2022-01-08', 'Khalid', '2021-12-23'),
(72, 'sfs', '0', '2021-12-24', 'Khalid', '2021-12-18'),
(73, 'jgfj', '0', '2021-12-18', 'Khalid', '2021-12-17'),
(74, 'rur', '36', '2021-12-17', 'Khalid', '2021-12-18'),
(75, 'u6u', '44', '2021-12-18', 'Khalid', '2021-12-17'),
(76, 'ri6r', '58', '2021-12-18', 'Khalid', '2021-12-17'),
(77, 'i6r', '0', '2021-12-18', 'Khalid', '2021-12-17'),
(78, 'i6rr', '0', '2021-12-18', 'Khalid', '2021-12-17'),
(79, 'ru6ru', '0', '2021-12-25', 'Khalid', '2021-12-18'),
(80, 'r6ur', '45', '2021-12-18', 'Khalid', '2021-12-17');

-- --------------------------------------------------------

--
-- Tabellstruktur `contacts`
--

CREATE TABLE `contacts` (
  `id` int(11) NOT NULL,
  `f_name` varchar(100) NOT NULL,
  `l_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellstruktur `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `body` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumpning av Data i tabell `posts`
--

INSERT INTO `posts` (`id`, `title`, `body`) VALUES
(1, 'Post one', 'this is post number one');

-- --------------------------------------------------------

--
-- Tabellstruktur `projects`
--

CREATE TABLE `projects` (
  `id` int(1) NOT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Author` varchar(255) DEFAULT NULL,
  `Date` varchar(255) DEFAULT NULL,
  `Deadline` varchar(255) DEFAULT NULL,
  `Workers` varchar(255) DEFAULT NULL,
  `Completed` varchar(255) DEFAULT NULL,
  `Precentage` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellstruktur `time`
--

CREATE TABLE `time` (
  `id` int(11) NOT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Username` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Hours` varchar(255) DEFAULT NULL,
  `Minutes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellstruktur `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `Username` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Active` int(11) DEFAULT NULL,
  `Created` int(11) DEFAULT NULL,
  `Completion` int(11) DEFAULT NULL,
  `Profile` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumpning av Data i tabell `users`
--

INSERT INTO `users` (`id`, `Username`, `Password`, `Name`, `Active`, `Created`, `Completion`, `Profile`) VALUES
(1, 'MXboss', '4{caGM2j`a#@$j83', 'Ljung', 0, 0, 0, 'Ljung.jpg'),
(2, 'MXkvist', 'TLk=?7zjX,V?PX{j', 'Kvist', 0, 0, 0, 'Kvist.jpg'),
(3, 'MXanders', 'xZM.%y9U!F7;~Q}h', 'Anders', 0, 0, 0, 'Anders.jpg'),
(4, 'MXphilip', 'kr3fG3(@X95{_>5;', 'Philip', 0, 0, 0, 'Philip.jpg'),
(5, 'MXkhalid', 'C~%!XZh!9vy}C8xk', 'Khalid', 0, 0, 0, 'Khalid.jpg');

--
-- Index för dumpade tabeller
--

--
-- Index för tabell `chart`
--
ALTER TABLE `chart`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `time`
--
ALTER TABLE `time`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT för dumpade tabeller
--

--
-- AUTO_INCREMENT för tabell `chart`
--
ALTER TABLE `chart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT för tabell `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT för tabell `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT för tabell `time`
--
ALTER TABLE `time`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT för tabell `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
