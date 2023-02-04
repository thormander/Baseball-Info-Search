--
-- Table structure for table `analysis`
--

DROP TABLE IF EXISTS `analysis`;
SET character_set_client = utf8mb4;
CREATE TABLE `analysis` (
  `analysis_ID` int(11) NOT NULL AUTO_INCREMENT,
  `playerID` varchar(9) NOT NULL,
  `yearID` smallint(6) NOT NULL,
  `age` smallint(6) DEFAULT NULL,
  `birthYear` smallint(6) DEFAULT NULL,
  `teamID` varchar(3) DEFAULT NULL,
  `lgID` varchar(2) DEFAULT NULL,
  `G` smallint(6) DEFAULT NULL,
  `AB` smallint(6) DEFAULT NULL,
  `R` smallint(6) DEFAULT NULL,
  `H` smallint(6) DEFAULT NULL,
  `B2` smallint(6) DEFAULT NULL,
  `B3` smallint(6) DEFAULT NULL,
  `HR` smallint(6) DEFAULT NULL,
  `RBI` smallint(6) DEFAULT NULL,
  `SB` smallint(6) DEFAULT NULL,
  `CS` smallint(6) DEFAULT NULL,
  `BB` smallint(6) DEFAULT NULL,
  `SO` smallint(6) DEFAULT NULL,
  `IBB` smallint(6) DEFAULT NULL,
  `HBP` smallint(6) DEFAULT NULL,
  `SH` smallint(6) DEFAULT NULL,
  `SF` smallint(6) DEFAULT NULL,
  `GIDP` smallint(6) DEFAULT NULL,
  `OBP` numeric(5,3) DEFAULT NULL,
  `TB` smallint(6) DEFAULT NULL,
  `RC` numeric(5,1) DEFAULT NULL,
  `RC27` numeric(5,2) DEFAULT NULL,
  `PA` smallint(6) DEFAULT NULL,
  `SLG` numeric(4,3) DEFAULT NULL,
  `OPS` numeric(4,3) DEFAULT NULL,
  `OPSplus` numeric(4,3) DEFAULT NULL,
  `BPF` int(11) DEFAULT NULL,
  `Pos` varchar(9) DEFAULT NULL,
  `PARC` numeric(5,1) DEFAULT NULL,
  `PARCper27` numeric(5,1) DEFAULT NULL,
  PRIMARY KEY (`analysis_ID`),
  UNIQUE KEY `analysisID` (`playerID`,`yearID`),
  CONSTRAINT `analysis_peoplefk` FOREIGN KEY (`playerID`) REFERENCES `batting` (`playerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

#if needed
#ALTER TABLE analysis CHANGE COLUMN 2B B2 smallint(6);
#ALTER TABLE analysis CHANGE COLUMN 3B B3 smallint(6);