-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 18, 2016 at 09:41 PM
-- Server version: 10.1.8-MariaDB
-- PHP Version: 5.6.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ideas`
--
CREATE DATABASE IF NOT EXISTS `ideas` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `ideas`;

-- --------------------------------------------------------

--
-- Table structure for table `downvotes`
--

CREATE TABLE `downvotes` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `itemid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ideas`
--

CREATE TABLE `ideas` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `text` text NOT NULL,
  `longid` varchar(20) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `week` int(11) NOT NULL,
  `userid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ideas`
--

INSERT INTO `ideas` (`id`, `title`, `text`, `longid`, `date`, `week`, `userid`) VALUES
(17, 'Interactive Infographic', 'Based on a topic all team members are interested in (gaming, history, a specific movie etc)', 'nwdTk2rmXF73HKu9vB9j', '2016-07-18 02:13:42', 1, 0),
(18, 'Chrome extension', '(theme, specifics probably required unless we go with themes rather than specific challenges).', '5ZtFgp6HsQhDEY8Py2s2', '2016-07-18 02:14:31', 1, 0),
(19, 'Caching Engine', 'Takes a full URL, caches it in full to an HTML file, engine searches cache folder before building page from scratch - if found, displays cached file. If not, builds normally. Engine parses full sitemap on a scheduled task.', 'sWaz7nEdqVcIZ6QazE3D', '2016-07-18 02:15:00', 1, 0),
(20, 'Calendar App', 'Click once on a date to expand to view details of events. Click again to expand further and view all events. Click again to shrink back to normal. Click on events to view detail and edit. Click on icon to add tasks to date.', 'rXdvKlo43qa1JwKDCnyk', '2016-07-18 02:15:49', 1, 0),
(21, 'Stock Market Portfolio App with auto-refresh', 'Add stock to portfolio and it records current price and tracks it until you remove it, showing gain since add to system. Auto-complete for searching by stock ticker or business name.', 'YvtG7jN5UXUie5eoQ1Wj', '2016-07-18 02:16:10', 1, 0),
(22, 'Stock Market Game', 'Allow users to create games where individuals can play stock-picking games against each other for a custom length of time. Watch out for stock splits and dividends (it’s how to “cheat” in these games). To combat, check relative price of historical data on date of purchase.', 'pGZC3yu74YPWT2yiH9vv', '2016-07-18 02:16:27', 1, 0),
(23, 'Minimalist Evernote Clone', 'A text area on screen with auto-save of content to localstorage. See WrittenKitten.co for example of how this can be done. Allow for multiple notes/tabs.', '7Vu9urWqdvDhY0rMOf8C', '2016-07-18 02:16:43', 1, 0),
(24, 'PDF Invoice Creator', 'Enter in relevant details for invoice and upload logo, produce a pretty PDF invoice and save it for simple edits later (since the clients and hours change, but not the header and footer of the invoice).', 'tjHSCpTDo4N5gxPGcWFr', '2016-07-18 02:16:56', 1, 0),
(25, 'T-Shirt Design Creator', 'Image manipulation! Add images and text to a picture and move it around, change fonts and colors, etc. Could be expanded to other types of products.', 'DfZpkt7B9Aqw3dA9qvlt', '2016-07-18 02:17:15', 1, 0),
(26, 'SMS engine', 'SMS over email is a thing. Enter a number, choose a provider and submit. Or use an SMS API like Trumpia, 3Seventy, Avidmobile, Sinch, Plivo, or the biggie: Twilio.', 'J1FDolkwojhww1sTTpfE', '2016-07-18 02:17:27', 1, 0),
(27, 'E-commerce engine', 'Sourced from a single JS include for sidebars of websites to sell 1-5 products. Simple admin for adding up to five products. Each admin gets their own unique 13-character identifier code.', 'kJLSNSpEE7Cg11jmOCMP', '2016-07-18 02:18:00', 1, 0),
(28, 'Code Editor with Syntax Highlighting', 'There are several good JS libraries already built for syntax indentation/prettifying, but not a lot of great ones for syntax highlighting.', 'U5D1N1bvhIcL3UjFNHqP', '2016-07-18 02:18:25', 1, 0),
(29, 'Author/Writer Tools', 'Web-based programs that clone functionality of Scrivener allowing for better story outlining and storybuilding - basically, saving research and lore while also saving the actual story and chapters and allowing for export to e-book format, which is basically HTML (though it’s own brand of HTML).', 'eELa6QvUxsIGtMsYXH6j', '2016-07-18 02:19:00', 1, 0),
(30, 'Page to view projects', '(current and finished) with list of team members, description and end date', '7HhwG8ieEw7x1t9R3aZL', '2016-07-18 02:19:17', 1, 0),
(31, 'Random Google Font Combination generator, with user curation.', 'Every time a user encounters a nice combination, they could ‘upvote’ it, most upvoted font combos could then go on a ‘most liked combos’ page. Google Fonts has a simple API to grab necessary data.', 'KUVYuq3laU5PFkL84aRY', '2016-07-18 02:19:40', 1, 0),
(32, 'Online learning tool', 'Something like edx/coursera, where you had people as students taking classes, and people as teachers, uploading courses and class materials.', 'HaV6gQOCrHgC73pQYfbV', '2016-07-18 02:19:55', 1, 0),
(33, 'A simple card game.', 'Just look at the title. Could do with html, or with canvas etc.\n\nMultiplayer?', 'mHo2QzxICdyxAJaKLngp', '2016-07-18 02:20:36', 1, 0),
(34, 'Online documentation on various languages.', 'It could have interactive (sort of like a code editor) examples of commands and/or coding techniques.', 'iZeFTcncdPTmTWNWL2JE', '2016-07-18 02:20:49', 1, 0),
(35, 'A webapp/search-engine that can search on the ENTIRE internet/web', '(To big scale + Would cost a fortune) (I think this one was a larf.)', 'KJwZk8lecmdkfvJRY5vd', '2016-07-18 02:21:33', 1, 0),
(36, 'Pick-up line generator-for all your tinder needs.', 'Generates pickup lines for you to use', '02NEVDDyM6aQZHtZdUui', '2016-07-18 02:21:54', 1, 0),
(37, 'Let’s make a messaging app for ourselves.', 'Would be like slack, but we could make it totally custom', 'S4QI4WOXdjb6lO48RCJb', '2016-07-18 02:22:21', 1, 0),
(38, 'Online multiplayer tic-tac-toe.', 'self explanatory', '11kXYBXoTqxVNN0JSmQS', '2016-07-18 02:22:31', 1, 0),
(39, 'Kitchen related app', 'You input ingredients you have at home, at it will output recipes you can do. (can add some extras, like calories and other stuff)', '0bNZDZkh6JjdIN4OhKiC', '2016-07-18 02:22:43', 1, 0),
(40, 'Make a HTML5 game.', '2D, 3D, RPG, space shooter, etc. Could really be anything.', 'L1cLZLEaAvlmcYkfITxl', '2016-07-18 02:23:11', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `upvotes`
--

CREATE TABLE `upvotes` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `itemid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `upvotes`
--

INSERT INTO `upvotes` (`id`, `userid`, `date`, `itemid`) VALUES
(45, 6, '2016-07-17 21:34:51', 14),
(46, 6, '2016-07-17 21:38:18', 15),
(51, 6, '2016-07-18 02:09:44', 16),
(52, 6, '2016-07-18 02:13:42', 17),
(55, 6, '2016-07-18 02:15:49', 20),
(56, 6, '2016-07-18 02:16:10', 21),
(57, 6, '2016-07-18 02:16:27', 22),
(59, 6, '2016-07-18 02:16:56', 24),
(60, 6, '2016-07-18 02:17:15', 25),
(61, 6, '2016-07-18 02:17:27', 26),
(62, 6, '2016-07-18 02:18:00', 27),
(63, 6, '2016-07-18 02:18:25', 28),
(64, 6, '2016-07-18 02:19:00', 29),
(65, 6, '2016-07-18 02:19:17', 30),
(66, 6, '2016-07-18 02:19:40', 31),
(67, 6, '2016-07-18 02:19:55', 32),
(68, 6, '2016-07-18 02:20:36', 33),
(69, 6, '2016-07-18 02:20:49', 34),
(70, 6, '2016-07-18 02:21:33', 35),
(71, 6, '2016-07-18 02:21:54', 36),
(72, 6, '2016-07-18 02:22:21', 37),
(74, 6, '2016-07-18 02:22:43', 39),
(76, 6, '2016-07-18 02:47:07', 19),
(77, 6, '2016-07-18 02:47:09', 18),
(78, 6, '2016-07-18 03:31:44', 40),
(81, 6, '2016-07-18 05:59:50', 23),
(83, 6, '2016-07-18 06:49:53', 38);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `longid` varchar(60) NOT NULL,
  `datejoined` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastactive` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `passkey` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `longid`, `datejoined`, `lastactive`, `passkey`) VALUES
(1, 'qawuImOVGzz8TOsOS3Hqz7y1R0blggapAM0d2YP2qMhDDRwcyZT84jdePJUK', '2016-07-17 08:15:53', '2016-07-17 04:15:53', ''),
(2, 'YJdNAfSejYkALDxEtadqVUyS4vAvZbOUaKofmJaEJHVtvYiBLTCuzHjxxbS9', '2016-07-17 08:16:21', '2016-07-17 04:16:21', ''),
(3, '3BJjCrX3KNNfW9B2WdwfbknYMAorkEbUn1oU6kUw2728xzjgJFobhZjyMUbU', '2016-07-17 08:16:23', '2016-07-17 04:16:23', ''),
(4, '4KNwL2iUnodooEhp4SZcwXrn4XJ1HRWAImC6v9rb46ocjVZHXpav5luGV4SN', '2016-07-17 08:22:12', '2016-07-17 04:22:12', '557lQ3GYz65VD7O'),
(5, 'aVD9YG5yyQ9jLx5v1i2A36LiWDIqbGDnoFYTiw6y3aZaD39u3gUnUEsJs3Ef', '2016-07-17 15:55:45', '2016-07-17 11:55:45', 'sSbbqVox4hdNthI'),
(6, 'MsXPVCuiqJfdK6M7Qmueb1GmBdCWFOKj8MiEXXPnJZiXmEo3Hs1YelE3VPvh', '2016-07-17 15:57:21', '2016-07-17 11:57:21', 'SUlg4Z1ySjhFJuK');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `downvotes`
--
ALTER TABLE `downvotes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ideas`
--
ALTER TABLE `ideas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ideaurlid` (`longid`);

--
-- Indexes for table `upvotes`
--
ALTER TABLE `upvotes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `longid` (`longid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `downvotes`
--
ALTER TABLE `downvotes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ideas`
--
ALTER TABLE `ideas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT for table `upvotes`
--
ALTER TABLE `upvotes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
