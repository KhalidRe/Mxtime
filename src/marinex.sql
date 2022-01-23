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



--
-- Dumpning av Data i tabell `chart`
--



-- --------------------------------------------------------

--
-- Tabellstruktur `contacts`
--

CREATE TABLE `contacts` (
  `id` int(11) NOT NULL PRIMARY KEY,
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
  `id` int(1) NOT NULL PRIMARY KEY,
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
  `id` int(11) NOT NULL PRIMARY KEY,
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
  `id` int(11) NOT NULL PRIMARY KEY,
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
