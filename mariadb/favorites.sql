--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
CREATE TABLE `favorites` (
  `favorites_ID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `playerid` varchar(9) NOT NULL,
  `user` varchar(50) NOT NULL
);