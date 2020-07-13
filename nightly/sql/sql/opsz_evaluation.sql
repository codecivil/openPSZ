-- Please create table opsz_refukey in openStatAdmin before applying this patch

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `opsz_refukey`
--

DROP TABLE IF EXISTS `opsz_refukey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opsz_refukey` (
  `id_opsz_refukey` int(11) NOT NULL AUTO_INCREMENT,
  `changedat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `changedby` int(11) DEFAULT NULL,
  `code` varchar(20) DEFAULT replace(replace(replace(ucase(left(to_base64(unhex(sha(concat(current_timestamp(),rand())))),8)),'/','1'),'+','2'),'=','3'),
  `id_opsz_aufnahme` int(11) DEFAULT NULL,
  `id_opsz_termine` int(11) DEFAULT NULL,
  `id_opsz_db` int(11) DEFAULT NULL,
  `id_os_calendars` int(11) DEFAULT NULL,
  `id_opsz_kosten` int(11) DEFAULT NULL,
  `id_opsz_vermittlungslisten` int(11) DEFAULT NULL,
  `evalnoeval` text DEFAULT NULL,
  `fallnummerklinik` text DEFAULT NULL,
  `erstkontaktrefukey` date DEFAULT NULL,
  `ueberleitung` varchar(40) DEFAULT NULL,
  `familienstand` varchar(40) DEFAULT NULL,
  `familiehier` varchar(8) DEFAULT NULL,
  `berichtvorhanden` varchar(8) DEFAULT NULL,
  `berichtvon` text DEFAULT NULL,
  `anmerkungen` text DEFAULT NULL,
  `standderakte` varchar(40) DEFAULT NULL,
  `badoiiausgefuellt` varchar(8) DEFAULT NULL,
  `badoiiausgefuelltam` date DEFAULT NULL,
  `refukeyiausgefuellt` varchar(8) DEFAULT NULL,
  `refkeyiausgefuelltam` date DEFAULT NULL,
  `refukeyiiausgefuelltzehn` varchar(8) DEFAULT NULL,
  `refukeyiiausgefuelltzehnam` date DEFAULT NULL,
  `refukeyiiausgefuelltende` varchar(8) DEFAULT NULL,
  `refukeyiiausgefuelltendeam` date DEFAULT NULL,
  `besonderheiten` text DEFAULT NULL,
  `gescannt` varchar(8) DEFAULT NULL,
  `dropout` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id_opsz_refukey`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 `ENCRYPTED`=YES;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `opsz_refukey_permissions`
--

LOCK TABLES `opsz_refukey_permissions` WRITE;
/*!40000 ALTER TABLE `opsz_refukey_permissions` DISABLE KEYS */;
DELETE FROM opsz_refukey_permissions;
INSERT INTO `opsz_refukey_permissions` VALUES (1,'changedat','_none_',NULL,'TIMESTAMP','NONE',NULL,'_none_'),(2,'changedby','_none_',NULL,'VARCHAR(40)','NONE',NULL,'_none_'),(3,'code','Code',3.000,'VARCHAR(20)','TEXT','(REPLACE(REPLACE(REPLACE(upper(LEFT(to_base64(UNHEX(sha1(CONCAT(NOW(),RAND())))),8)),\'/\',\'1\'),\'+\',\'2\'),\'=\',\'3\'))',NULL),(7,'evalnoeval','Wenn kein Evaluationsbogen, warum nicht?',22.000,'TEXT','FREE',NULL,NULL),(10,'fallnummerklinik','Fallnummer des Klinikums',3.500,'TEXT','TEXT',NULL,NULL),(11,'erstkontaktrefukey','Erstkontakt zu refuKey',4.000,'DATE','DATE',NULL,NULL),(12,'ueberleitung','Überleitung innerhalb refukey',5.000,'VARCHAR(40)','LIST',NULL,'_evalueberleitung'),(13,'familienstand','Familienstand',6.000,'VARCHAR(40)','LIST',NULL,'_familienstand'),(14,'familiehier','Familie hier',7.000,'VARCHAR(8)','LIST',NULL,'_binary'),(15,'berichtvorhanden','Bericht vorhanden',8.000,'VARCHAR(8)','LIST',NULL,'_yesno'),(16,'berichtvon','Bericht von',9.000,'VARCHAR(60)','SUGGEST; MULTIPLE',NULL,NULL),(17,'anmerkungen','Anmerkungen',10.000,'TEXT','FREE',NULL,NULL),(18,'standderakte','Stand der Akte',11.000,'VARCHAR(40)','LIST',NULL,'_standderakte'),(19,'badoiiausgefuellt','BADO II ausgefüllt',12.000,'VARCHAR(8)','LIST',NULL,'_yesno'),(20,'badoiiausgefuelltam','BADO II ausgefüllt am',13.000,'DATE','DATE',NULL,NULL),(21,'refukeyiausgefuellt','RefuKey-Fragebogen I ausgefüllt',14.000,'VARCHAR(8)','LIST',NULL,'_yesno'),(22,'refkeyiausgefuelltam','RefuKey-Fragebogen I ausgefüllt am',15.000,'DATE','DATE',NULL,NULL),(23,'refukeyiiausgefuelltzehn','RefuKey-Fragebogen II nach 10 Sitzungen ausgefüllt',16.000,'VARCHAR(8)','LIST',NULL,'_yesno'),(24,'refukeyiiausgefuelltzehnam','RefuKey-Fragebogen II nach 10 Sitzungen ausgefüllt am',17.000,'DATE','DATE',NULL,NULL),(25,'refukeyiiausgefuelltende','RefuKey-Fragebogen II am Ende der Sitzungen ausgefüllt',18.000,'VARCHAR(8)','LIST',NULL,'_yesno'),(26,'refukeyiiausgefuelltendeam','RefuKey-Fragebogen II am Ende der Sitzungen ausgefüllt am',19.000,'DATE','DATE',NULL,NULL),(27,'besonderheiten','Besonderheiten / Bemerkungen zur Evaluation',20.000,'TEXT','FREE',NULL,NULL),(28,'gescannt','Fragebögen gescannt',21.000,'VARCHAR(8)','LIST',NULL,'_yesno'),(29,'dropout','Dropout Kategorien',23.000,'VARCHAR(60)','LIST',NULL,'_dropout');
/*!40000 ALTER TABLE `opsz_refukey_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opsz_refukey_references`
--

DROP TABLE IF EXISTS `opsz_refukey_references`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opsz_refukey_references` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referencetag` varchar(40) DEFAULT NULL,
  `depends_on_key` varchar(80) DEFAULT NULL,
  `depends_on_value` varchar(80) DEFAULT NULL,
  `allowed_values` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 `ENCRYPTED`=YES;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opsz_refukey_references`
--

LOCK TABLES `opsz_refukey_references` WRITE;
/*!40000 ALTER TABLE `opsz_refukey_references` DISABLE KEYS */;
INSERT INTO `opsz_refukey_references` VALUES (1,'_none_',NULL,NULL,NULL),(2,'_evalueberleitung',NULL,NULL,'[\"*nein\",\"PSZ Braunschweig\",\"PSZ Göttingen\",\"PSZ Oldenburg \",\"PSZ Osnabrück\",\"PSZ Lüneburg\",\"AWO Psychiatriezentrum Königslutter\",\"Asklepios Fachklinikum Göttingen\" ,\"Niels-Stensen-Kliniken Bramsche\",\"Karl-Jaspers Klinik Wehnen\"]'),(3,'_familienstand',NULL,NULL,'[\"ledig\",\"verheiratet\",\"verwitwet\",\"geschieden\",\"eingetragene Lebenspartnerschaft\",\"Ehe / Lebenspartnerschaft aufgehoben\",\"*nicht bekannt\"]'),(4,'_yesno',NULL,NULL,'[\"ja\",\"*nein\"]'),(5,'_standderakte',NULL,NULL,'[\"aufgenommen\",\"neu aufgenommen (aus Vorjahr)\",\"neu aufgenommen (Evaluation)\",\"OS\",\"Einzeltermine → OS\",\"vermittelt\",\"*nicht aufgenommen\",\"geschlossen\"]'),(6,'_dropout',NULL,NULL,'[\"*keine\",\"Behandlungsabbruch ohne Angabe von Gründen\",\"Gründe auf Seiten des Behandlers\",\"Vermittlung (extern)\",\"Behandlungsabbruch durch Umverteilung\",\"Behandlungsabbruch durch Ausreise\"]'),(7,'_binary',NULL,NULL,'[\"*zu klären\",\"ja\",\"nein\"]');
/*!40000 ALTER TABLE `opsz_refukey_references` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
