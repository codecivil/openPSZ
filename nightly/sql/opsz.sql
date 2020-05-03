-- MySQL dump 10.17  Distrib 10.3.22-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: opsz_template
-- ------------------------------------------------------
-- Server version	10.3.22-MariaDB-0+deb10u1

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
-- Table structure for table `opsz_aufnahme`
--

DROP TABLE IF EXISTS `opsz_aufnahme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opsz_aufnahme` (
  `id_opsz_aufnahme` int(11) NOT NULL AUTO_INCREMENT,
  `changedat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `changedby` int(11) DEFAULT NULL,
  `aufnahmedatum` date DEFAULT NULL,
  `id_opsz_termine` int(11) DEFAULT NULL,
  `id_opsz_db` int(11) DEFAULT NULL,
  `id_os_calendars` int(11) DEFAULT NULL,
  `verantwortlich` text DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `vorname` varchar(40) DEFAULT NULL,
  `herkunft` varchar(40) DEFAULT NULL,
  `sprache` text DEFAULT NULL,
  `geschlecht` varchar(40) DEFAULT NULL,
  `geburtsdatum` date DEFAULT NULL,
  `kinder` int(11) DEFAULT NULL,
  `kinderdetail` text DEFAULT NULL,
  `adresse` text DEFAULT NULL,
  `telefon` varchar(40) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `symptome` text DEFAULT NULL,
  `anzeichen` text DEFAULT NULL,
  `dolmetscher` text DEFAULT NULL,
  `hausarzt` text DEFAULT NULL,
  `swe_hausarzt` varchar(10) DEFAULT NULL,
  `vorerkrankungen` text DEFAULT NULL,
  `medikamente` text DEFAULT NULL,
  `psychiater` text DEFAULT NULL,
  `swe_psychiater` varchar(10) DEFAULT NULL,
  `mobilität` text DEFAULT NULL,
  `geschlechttherapeutwichtig` varchar(255) DEFAULT NULL,
  `gesundheitsversorgung` varchar(40) DEFAULT NULL,
  `indeutschlandseit` date DEFAULT NULL,
  `unterstuetzer` text DEFAULT NULL,
  `swe_unterstuetzer` varchar(10) DEFAULT NULL,
  `beratungsstellen` text DEFAULT NULL,
  `familienhilfe` text DEFAULT NULL,
  `aufenthaltsstatus` varchar(40) DEFAULT NULL,
  `aufenthaltsprobleme` text DEFAULT NULL,
  `rechtsanwalt` text DEFAULT NULL,
  `swe_rechtsanwalt` varchar(10) DEFAULT NULL,
  `hinweise` text DEFAULT NULL,
  `sozialanamnese` text DEFAULT NULL,
  `id_opsz_kosten` int(11) DEFAULT NULL,
  `id_opsz_vermittlungslisten` int(11) DEFAULT NULL,
  `aktiv` varchar(10) DEFAULT NULL,
  `krankenversicherungdetail` varchar(60) DEFAULT NULL,
  `lebensunterhalt` varchar(40) DEFAULT NULL,
  `lebensunterhaltdetail` varchar(60) DEFAULT NULL,
  `anfragevon` varchar(40) DEFAULT NULL,
  `jugendlich` varchar(10) DEFAULT NULL,
  `begleitet` varchar(40) DEFAULT NULL,
  `terminebei` varchar(40) DEFAULT NULL,
  `vermittlung` varchar(10) DEFAULT NULL,
  `aufnahmepsz` varchar(10) DEFAULT NULL,
  `listestellungnahme` varchar(10) DEFAULT NULL,
  `stellungnahmeseit` date DEFAULT NULL,
  `diagnose` text DEFAULT NULL,
  `diagnosedetail` varchar(60) DEFAULT NULL,
  `vulnerabilitaet` text DEFAULT NULL,
  `angebot` text DEFAULT NULL,
  `angebotedetail` text DEFAULT NULL,
  `telefondetail` text DEFAULT NULL,
  `emaildetail` text DEFAULT NULL,
  `anzeichendetail` text DEFAULT NULL,
  `landkreisregion` varchar(60) DEFAULT NULL,
  `sprachedetail` text DEFAULT NULL,
  `swe_krankenversicherung` varchar(10) DEFAULT NULL,
  `swe_familienhilfe` varchar(10) DEFAULT NULL,
  `kv_geaendert` date DEFAULT NULL,
  `dateien` text DEFAULT NULL,
  `fruehdiagnostik` varchar(10) DEFAULT NULL,
  `kuj` varchar(10) DEFAULT NULL,
  `vermittlungsstand` varchar(40) DEFAULT NULL,
  `aufenthaltorig` varchar(40) DEFAULT NULL,
  `_gesundheitorig` varchar(40) DEFAULT NULL,
  `minderheit` varchar(60) DEFAULT NULL,
  `anzeichenkommentar` text DEFAULT NULL,
  `code` varchar(8) DEFAULT replace(replace(replace(ucase(left(to_base64(unhex(sha(concat(current_timestamp(),rand())))),8)),'/','1'),'+','2'),'=','3'),
  PRIMARY KEY (`id_opsz_aufnahme`)
) ENGINE=InnoDB AUTO_INCREMENT=1030 DEFAULT CHARSET=utf8mb4 `ENCRYPTED`=YES;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opsz_aufnahme`
--

LOCK TABLES `opsz_aufnahme` WRITE;
/*!40000 ALTER TABLE `opsz_aufnahme` DISABLE KEYS */;
/*!40000 ALTER TABLE `opsz_aufnahme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opsz_aufnahme_permissions`
--

DROP TABLE IF EXISTS `opsz_aufnahme_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opsz_aufnahme_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keymachine` varchar(40) DEFAULT NULL,
  `keyreadable` varchar(255) DEFAULT NULL,
  `realid` decimal(6,3) DEFAULT NULL,
  `typelist` varchar(40) DEFAULT NULL,
  `edittype` varchar(60) DEFAULT NULL,
  `defaultvalue` text DEFAULT NULL,
  `referencetag` varchar(40) DEFAULT NULL,
  `role_0` int(11) DEFAULT 0,
  `restrictrole_0` text DEFAULT NULL,
  `role_1` int(11) DEFAULT 0,
  `restrictrole_1` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 `ENCRYPTED`=YES;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opsz_aufnahme_permissions`
--

LOCK TABLES `opsz_aufnahme_permissions` WRITE;
/*!40000 ALTER TABLE `opsz_aufnahme_permissions` DISABLE KEYS */;
INSERT INTO `opsz_aufnahme_permissions` VALUES (1,'changedat','_none_',1.000,'TIMESTAMP','NONE',NULL,NULL,0,NULL,0,NULL),(2,'changedby','_none_',2.000,'VARCHAR(40)','NONE',NULL,NULL,0,NULL,0,NULL),(3,'aufnahmedatum','Aufnahmedatum',3.000,'DATE','DATE',NULL,NULL,0,NULL,0,NULL),(4,'verantwortlich','Fallverantwortliche(r)',4.000,'TEXT','EXTENSIBLE LIST',NULL,NULL,0,NULL,0,NULL),(5,'name','Nachname',5.000,'VARCHAR(40)','TEXT',NULL,NULL,0,NULL,0,NULL),(6,'vorname','Vorname',6.000,'VARCHAR(40)','TEXT',NULL,NULL,0,NULL,0,NULL),(7,'herkunft','Herkunftsland',7.000,'VARCHAR(40)','EXTENSIBLE LIST',NULL,NULL,0,NULL,0,NULL),(8,'sprache','Sprache',8.000,'TEXT','EXTENSIBLE LIST; MULTIPLE',NULL,NULL,0,NULL,0,NULL),(9,'geschlecht','Geschlecht',9.000,'VARCHAR(40)','LIST',NULL,'_geschlecht',0,NULL,0,NULL),(10,'geburtsdatum','Geburtsdatum',10.000,'DATE','DATE',NULL,NULL,0,NULL,0,NULL),(11,'kinder','Kinder',11.000,'INT','INTEGER',NULL,NULL,0,NULL,0,NULL),(12,'kinderdetail','Angaben zu Kindern',12.000,'TEXT','TEXT',NULL,NULL,0,'',0,''),(13,'adresse','Adresse',13.000,'TEXT','FREE',NULL,NULL,0,NULL,0,NULL),(14,'telefon','Telefon',14.000,'VARCHAR(40)','PHONE',NULL,NULL,0,NULL,0,NULL),(15,'email','E-Mail',15.000,'VARCHAR(60)','EMAIL',NULL,NULL,0,NULL,0,NULL),(16,'symptome','Symptome/Beschwerden/Anliegen',16.000,'TEXT','EDITOR',NULL,NULL,0,NULL,0,NULL),(17,'anzeichen','Anzeichen',17.000,'TEXT','CHECKBOX',NULL,'_anzeichen',0,NULL,0,NULL),(18,'dolmetscher','Dolmetscher',18.000,'TEXT','FREE',NULL,NULL,0,NULL,0,NULL),(19,'hausarzt','HausärztIn (Adresse)',19.000,'TEXT','FREE',NULL,NULL,0,NULL,0,NULL),(20,'swe_hausarzt','SWE (Hausarzt)  liegt vor',20.000,'VARCHAR(10)','LIST',NULL,'_swe',0,NULL,0,NULL),(21,'vorerkrankungen','Vorerkrankungen',21.000,'TEXT','FREE',NULL,NULL,0,NULL,0,NULL),(22,'medikamente','Medikamente',22.000,'TEXT','FREE',NULL,NULL,0,NULL,0,NULL),(23,'psychiater','PsychiaterIn',23.000,'TEXT','FREE',NULL,NULL,0,NULL,0,NULL),(24,'swe_psychiater','SWE (PsychiaterIn) liegt vor',24.000,'VARCHAR(10)','LIST',NULL,'_swe',0,NULL,0,NULL),(25,'mobilität','Mobilität',25.000,'TEXT','TEXT',NULL,NULL,0,NULL,0,NULL),(26,'geschlechttherapeutwichtig','Ist es wichtig, ob Psychotherapeutin oder Psychotherapeut',26.000,'VARCHAR(255)','EXTENSIBLE LIST',NULL,'_geschlechttherapeutwichtig',0,NULL,0,NULL),(27,'gesundheitsversorgung','Krankenversicherung',27.000,'VARCHAR(40)','LIST',NULL,'_gesundheitsversorgung',0,NULL,0,NULL),(28,'indeutschlandseit','Seit wann in Deutschland',28.000,'DATE','DATE',NULL,NULL,0,NULL,0,NULL),(29,'unterstuetzer','UnterstützerIn',29.000,'TEXT','FREE',NULL,NULL,0,NULL,0,NULL),(30,'swe_unterstuetzer','SWE (Unterstützerin) liegt vor',30.000,'VARCHAR(10)','LIST',NULL,'_swe',0,NULL,0,NULL),(31,'beratungsstellen','Beratungsstellen vor Ort',31.000,'TEXT','FREE',NULL,NULL,0,NULL,0,NULL),(32,'familienhilfe','Familienhilfe/ Vormundschaft',32.000,'TEXT','FREE',NULL,NULL,0,NULL,0,NULL),(33,'aufenthaltsstatus','Aufenthaltsstatus',33.000,'VARCHAR(40)','EXTENSIBLE LIST',NULL,'_aufenthaltsstatus',0,NULL,0,NULL),(34,'aufenthaltsprobleme','Gibt es Aufenthaltsprobleme?',34.000,'TEXT','TEXT',NULL,NULL,0,NULL,0,NULL),(35,'rechtsanwalt','RechtsanwältIn',35.000,'TEXT','FREE',NULL,NULL,0,NULL,0,NULL),(36,'swe_rechtsanwalt','SWE (RechtsanwältIn) liegt vor',36.000,'VARCHAR(10)','LIST',NULL,'_swe',0,NULL,0,NULL),(37,'hinweise','Wichtige Hinweise',37.000,'TEXT','EDITOR',NULL,NULL,0,NULL,0,NULL),(38,'sozialanamnese','Sozialanamnese',38.000,'TEXT','EDITOR',NULL,NULL,0,NULL,0,NULL),(39,'aktiv','Aktiv',2.500,'VARCHAR(10)','LIST',NULL,'_binary',0,NULL,0,NULL),(40,'krankenversicherungdetail','Krankenvers. Detail',27.200,'VARCHAR(60)','SUGGEST',NULL,NULL,0,NULL,0,NULL),(41,'lebensunterhalt','Lebensunterhalt',27.400,'VARCHAR(40)','LIST',NULL,'_lebensunterhalt',0,NULL,0,NULL),(42,'lebensunterhaltdetail','Lebensunterhalt Detail',27.600,'VARCHAR(60)','SUGGEST',NULL,NULL,0,NULL,0,NULL),(43,'anfragevon','Anfrage von',43.000,'VARCHAR(40)','EXTENSIBLE LIST',NULL,'_anfragevon',0,NULL,0,NULL),(44,'jugendlich','jugendlich',44.000,'VARCHAR(10)','LIST',NULL,'_yesno',0,NULL,0,NULL),(45,'begleitet','Begleitung',45.000,'VARCHAR(40)','LIST',NULL,'_begleitet',0,NULL,0,NULL),(46,'terminebei','Termine bei',49.000,'VARCHAR(40)','EXTENSIBLE LIST',NULL,NULL,0,NULL,0,NULL),(48,'vermittlung','Vermittlung',47.000,'VARCHAR(10)','LIST',NULL,'_yesno',0,NULL,0,NULL),(49,'aufnahmepsz','Aufnahme PSZ',48.000,'VARCHAR(10)','LIST',NULL,'_binary',0,NULL,0,NULL),(50,'listestellungnahme','Aufnahme Liste Stellungnahme',50.000,'VARCHAR(10)','LIST',NULL,'_binary',0,NULL,0,NULL),(51,'stellungnahmeseit','Auf Liste Stellungnahme seit',51.000,'DATE','DATE',NULL,NULL,0,NULL,0,NULL),(54,'diagnose','Diagnose',54.000,'TEXT','EXTENSIBLE LIST; MULTIPLE',NULL,'_diagnose',0,NULL,0,NULL),(55,'diagnosedetail','Diagnose-Detail',55.000,'VARCHAR(60)','EXTENSIBLE LIST',NULL,'_diagnosedetail',0,NULL,0,NULL),(56,'vulnerabilitaet','Vulnerabilität',56.000,'TEXT','CHECKBOX',NULL,'_vulnerabilitaet',0,NULL,0,NULL),(58,'angebot','Angebote',58.000,'TEXT','CHECKBOX',NULL,'_angebote',0,NULL,0,NULL),(59,'angebotedetail','Angebote-Detail',59.000,'TEXT','EXTENSIBLE LIST; MULTIPLE',NULL,'_angebotedetail',0,NULL,0,NULL),(60,'telefondetail','Telefon-Kommentar',14.500,'TEXT','TEXT',NULL,NULL,0,NULL,0,NULL),(61,'emaildetail','E-Mail-Kommentar',15.500,'TEXT','TEXT',NULL,NULL,0,NULL,0,NULL),(62,'anzeichendetail','Anzeichen-Detail',17.500,'TEXT','EXTENSIBLE CHECKBOX',NULL,'_anzeichendetail',0,NULL,0,NULL),(63,'landkreisregion','Landkreis/Region',13.500,'VARCHAR(60)','TEXT',NULL,NULL,0,NULL,0,NULL),(64,'sprachedetail','Sprache-Kommentat',8.500,'TEXT','TEXT',NULL,NULL,0,NULL,0,NULL),(65,'swe_krankenversicherung','SWE (Krankenvers. und Lebensunterhalt) liegt vor',27.800,'VARCHAR(10)','LIST',NULL,'_swe',0,NULL,0,NULL),(66,'swe_familienhilfe','SWE (Familienhilfe) liegt vor',32.500,'VARCHAR(10)','LIST',NULL,'_swe',0,NULL,0,NULL),(67,'kv_geaendert','KV geändert am',27.300,'DATE','DATE',NULL,NULL,0,NULL,0,NULL),(68,'dateien','Dateien',6.500,'TEXT','FILESPATH',NULL,NULL,0,NULL,0,NULL),(69,'fruehdiagnostik','Frühdiagnostik-Oerbke',48.500,'VARCHAR(10)','LIST',NULL,'_yesno',0,NULL,0,NULL),(70,'kuj','Kinder- und Jugendteam',48.700,'VARCHAR(10)','LIST',NULL,'_yesno',0,NULL,0,NULL),(71,'vermittlungsstand','Vermittlungsstand',47.500,'VARCHAR(40)','LIST',NULL,'_vermittlungsstand',0,NULL,0,NULL),(72,'aufenthaltorig','Aufenthaltsstaus bei Erstanmeldung',32.800,'VARCHAR(40)','EXTENSIBLE LIST',NULL,'_aufenthaltsstatus',0,NULL,0,NULL),(73,'_gesundheitorig','Krankenversicherung bei Erstanmeldung',26.800,'VARCHAR(40)','LIST',NULL,'_gesundheitsversorgung',0,NULL,0,NULL),(74,'minderheit','Minderheit',57.000,'VARCHAR(60)','EXTENSIBLE LIST',NULL,'_keine',0,NULL,0,NULL),(75,'anzeichenkommentar','Anzeichen-Kommentar',17.700,'TEXT','FREE',NULL,NULL,0,NULL,0,NULL),(76,'code','Code',0.101,'VARCHAR(8)','ID','(REPLACE(REPLACE(REPLACE(upper(LEFT(to_base64(UNHEX(sha1(CONCAT(NOW(),RAND())))),8)),\'/\',\'1\'),\'+\',\'2\'),\'=\',\'3\'))',NULL,6,NULL,0,NULL);
/*!40000 ALTER TABLE `opsz_aufnahme_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opsz_aufnahme_references`
--

DROP TABLE IF EXISTS `opsz_aufnahme_references`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opsz_aufnahme_references` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referencetag` varchar(40) DEFAULT NULL,
  `depends_on_key` varchar(80) DEFAULT NULL,
  `depends_on_value` varchar(80) DEFAULT NULL,
  `allowed_values` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 `ENCRYPTED`=YES;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opsz_aufnahme_references`
--

LOCK TABLES `opsz_aufnahme_references` WRITE;
/*!40000 ALTER TABLE `opsz_aufnahme_references` DISABLE KEYS */;
INSERT INTO `opsz_aufnahme_references` VALUES (2,'_none_',NULL,NULL,NULL),(4,'_anzeichen',NULL,NULL,'[\"*zu klären\",\"schädlicher Gebrauch\",\"Abhängigkeit/en\",\"riskanter Konsum\",\"missbräuchlicher Konsum\",\"keine\"]'),(5,'_binary',NULL,NULL,'[\"*zu klären\",\"ja\",\"nein\"]'),(6,'_gesundheitsversorgung',NULL,NULL,'[\"*zu klären\",\"Sozialamt\",\"Krankenkasse\",\"Krankenkasse über Sozialamt\",\"keine\"]'),(7,'_aufenthaltsstatus',NULL,NULL,'[\"*zu klären\",\"Aufenthaltspapiere\",\"keine\",\"Aufenthaltsgestattung\",\"Aufenthaltserlaubnis\",\"Duldung\"]'),(8,'_lebensunterhalt',NULL,NULL,'[\"*zu klären\",\"Sozialamt\",\"Jobcenter\",\"Arbeit\"]'),(9,'_begleitet',NULL,NULL,'[\"*zu klären\",\"mit Famile\",\"unbegleitet\",\"teilbegleitet\"]'),(10,'_diagnose',NULL,NULL,'[\"*zu klären\",\"PTBS\",\"Depression\",\"Angststörung\",\"somatoforme Störung\",\"körperliche Erkrankung\",\"Abhängigkeit\"]'),(11,'_diagnosedetail','diagnose','PTBS','[\"*zu klären\",\"v.a.\",\"gesichert\",\"komplexe PTBS\"]'),(12,'_diagnosedetail','diagnose','Depression','[\"*zu klären\",\"leicht\",\"mittel\",\"schwer\"]'),(13,'_vulnerabilitaet',NULL,NULL,'[\"*zu klären\",\"Folteropfer\",\"Gewaltopfer\",\"Opfer von Menschenhandel\",\"FGM\",\"Ü 60\",\"U 18\",\"umF\",\"schwanger\",\"alleinerziehend\",\"psychisch krank\",\"LSBTTIQ*\"]'),(14,'_vulnerabilitaetdetail','vulnerabilitaet','U 18','[\"*zu klären\",\"begleitet\",\"teilbegleitet\",\"unbegleitet\"]'),(15,'_angebote',NULL,NULL,'[\"*zu klären\",\"Einzelgespräche\",\"Gruppenangebot\",\"Vermittlung in die Regelversorgung\",\"Vermittlung: Beratungsstelle\",\"Vermittlung: PsychiaterIn\",\"Vermittlung: Psychotherapie\",\"Vermittlung: Rolling clinic\",\"ambulant betreutes Wohnen\",\"Projekt ASU\"]'),(16,'_angebotedetail','angebot','Einzelgespräche','[\"*zu klären\",\"kurz - 10 Termine\",\"mittel - 20 Termine\",\"langfristig - über 20 Termine\"]'),(17,'_angebotedetail','angebot','bei psychosozialer Beratung','[\"*zu klären\",\"PsychologIn\",\"PsychotherapeutIn\",\"ASU Projekt\",\"Sonstige Projekte\"]'),(18,'_angebotedetail','angebot','Gruppenangebot','[\"*zu klären\",\"PMR\",\"Freizeitgruppe\",\"Frauengruppe\"]'),(19,'_angebotedetail','angebot','Vermitlung in Fachberatung','[\"*zu klären\",\"ausländerrechtlich\",\"sozialrechtlich\",\"Lebensberatung, psychosoziale Beratung\",\"Suchtberatung\"]'),(20,'_angebotedetail','angebot','Vermittlung in die Regelversorgung','[\"*zu klären\",\"stationäre Aufnahme\",\"auf der Vermittlungsliste Psychiater\",\"auf der Vermittlungsliste Psychotherapeut\"]'),(21,'_vulnerabilitaetdetail',NULL,NULL,'[\"-\"]'),(22,'_diagnosedetail',NULL,NULL,'[\"-\"]'),(23,'_angebotedetail',NULL,NULL,'[\"-\"]'),(24,'_geschlecht',NULL,NULL,'[\"*zu klären\",\"männlich\",\"weiblich\",\"divers\"]'),(40,'_anfragevon',NULL,NULL,'[\"*zu klären\",\"LAB\",\"Gesundheitswesen\",\"RechtsanwältInnen\",\"ehrenamtlichen UnterstützerInnen\",\"Persönlich\",\"Beratungsstellen\",\"Community\",\"Flüchtlingssozialarbeit\",\"Behörden\",\"von anderen PSZ überwiesen\"]'),(41,'_geschlechttherapeutwichtig',NULL,NULL,'[\"*zu klären\",\"ja\",\"nein\",\"Mann\",\"Frau\"]'),(42,'_swe',NULL,NULL,'[\"*zu klären\",\"ja\",\"nein\",\"nicht anwendbar\"]'),(43,'_anzeichendetail',NULL,NULL,'[\"Alkohol\",\"Cannabinoide\",\"Heroin\",\"Kokain\",\"Medikamente\",\"Glücksspiel\",\"_Andere\"]'),(44,'_yesno',NULL,NULL,'[\"*nein\",\"ja\"]'),(45,'_vermittlungsstand','vermittlung','ja','[\"anderweitig\",\"erfolgreich\",\"im Prozess\"]'),(46,'_vermittlungsstand',NULL,NULL,' [\"-\"]'),(47,'_keine',NULL,NULL,'[\"*zu klären\",\"keine\"]');
/*!40000 ALTER TABLE `opsz_aufnahme_references` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opsz_db`
--

DROP TABLE IF EXISTS `opsz_db`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opsz_db` (
  `id_opsz_db` int(11) NOT NULL AUTO_INCREMENT,
  `changedat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `changedby` int(11) DEFAULT NULL,
  `id_opsz_aufnahme` int(11) DEFAULT NULL,
  `id_opsz_termine` int(11) DEFAULT NULL,
  `id_os_calendars` int(11) DEFAULT NULL,
  `id_opsz_kosten` int(11) DEFAULT NULL,
  `dbdatum` datetime DEFAULT NULL,
  `einschaetzung` text DEFAULT NULL,
  `vorschlag` text DEFAULT NULL,
  `akten` text DEFAULT NULL,
  `id_opsz_vermittlungslisten` int(11) DEFAULT NULL,
  `code` varchar(8) DEFAULT replace(replace(replace(ucase(left(to_base64(unhex(sha(concat(current_timestamp(),rand())))),8)),'/','1'),'+','2'),'=','3'),
  PRIMARY KEY (`id_opsz_db`)
) ENGINE=InnoDB AUTO_INCREMENT=397 DEFAULT CHARSET=utf8mb4 `ENCRYPTED`=YES;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opsz_db`
--

LOCK TABLES `opsz_db` WRITE;
/*!40000 ALTER TABLE `opsz_db` DISABLE KEYS */;
/*!40000 ALTER TABLE `opsz_db` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opsz_db_permissions`
--

DROP TABLE IF EXISTS `opsz_db_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opsz_db_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keymachine` varchar(40) DEFAULT NULL,
  `keyreadable` varchar(255) DEFAULT NULL,
  `realid` decimal(6,3) DEFAULT NULL,
  `typelist` varchar(40) DEFAULT NULL,
  `edittype` varchar(60) DEFAULT NULL,
  `defaultvalue` text DEFAULT NULL,
  `referencetag` varchar(40) DEFAULT NULL,
  `role_0` int(11) DEFAULT 0,
  `restrictrole_0` text DEFAULT NULL,
  `role_1` int(11) DEFAULT 0,
  `restrictrole_1` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 `ENCRYPTED`=YES;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opsz_db_permissions`
--

LOCK TABLES `opsz_db_permissions` WRITE;
/*!40000 ALTER TABLE `opsz_db_permissions` DISABLE KEYS */;
INSERT INTO `opsz_db_permissions` VALUES (1,'changedat','_none_',1.000,'TIMESTAMP','NONE',NULL,'_none_',0,NULL,0,NULL),(2,'changedby','_none_',2.000,'VARCHAR(40)','NONE',NULL,'_none_',0,NULL,0,NULL),(3,'dbdatum','Datum der DB',3.000,'DATETIME','DATETIME',NULL,'_none_',0,NULL,0,NULL),(4,'einschaetzung','erste Einschätzung',4.000,'TEXT','FREELONGER',NULL,'_none_',0,NULL,0,NULL),(5,'vorschlag','Vorschlag weiteres Vorgehen',5.000,'TEXT','FREELONGER',NULL,'_none_',0,NULL,0,NULL),(6,'akten','Akten',6.000,'TEXT','TEXT',NULL,'_none_',0,NULL,0,NULL),(7,'code','Code',0.100,'VARCHAR(8)','ID','(REPLACE(REPLACE(REPLACE(upper(LEFT(to_base64(UNHEX(sha1(CONCAT(NOW(),RAND())))),8)),\'/\',\'1\'),\'+\',\'2\'),\'=\',\'3\'))',NULL,6,NULL,0,NULL);
/*!40000 ALTER TABLE `opsz_db_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opsz_db_references`
--

DROP TABLE IF EXISTS `opsz_db_references`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opsz_db_references` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referencetag` varchar(40) DEFAULT NULL,
  `depends_on_key` varchar(80) DEFAULT NULL,
  `depends_on_value` varchar(80) DEFAULT NULL,
  `allowed_values` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 `ENCRYPTED`=YES;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opsz_db_references`
--

LOCK TABLES `opsz_db_references` WRITE;
/*!40000 ALTER TABLE `opsz_db_references` DISABLE KEYS */;
/*!40000 ALTER TABLE `opsz_db_references` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opsz_kosten`
--

DROP TABLE IF EXISTS `opsz_kosten`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opsz_kosten` (
  `id_opsz_kosten` int(11) NOT NULL AUTO_INCREMENT,
  `changedat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `changedby` int(11) DEFAULT NULL,
  `id_opsz_aufnahme` int(11) DEFAULT NULL,
  `id_opsz_termine` int(11) DEFAULT NULL,
  `id_opsz_db` int(11) DEFAULT NULL,
  `id_os_calendars` int(11) DEFAULT NULL,
  `zweck` varchar(40) DEFAULT NULL,
  `antragsdatum` date DEFAULT NULL,
  `entscheid` varchar(40) DEFAULT NULL,
  `widerspruch` varchar(40) DEFAULT NULL,
  `widerspruchsdatum` date DEFAULT NULL,
  `widerspruchsentscheid` varchar(40) DEFAULT NULL,
  `klage` varchar(40) DEFAULT NULL,
  `klagedatum` date DEFAULT NULL,
  `klageentscheid` varchar(40) DEFAULT NULL,
  `id_opsz_vermittlungslisten` int(11) DEFAULT NULL,
  `code` varchar(8) DEFAULT replace(replace(replace(ucase(left(to_base64(unhex(sha(concat(current_timestamp(),rand())))),8)),'/','1'),'+','2'),'=','3'),
  PRIMARY KEY (`id_opsz_kosten`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 `ENCRYPTED`=YES;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opsz_kosten`
--

LOCK TABLES `opsz_kosten` WRITE;
/*!40000 ALTER TABLE `opsz_kosten` DISABLE KEYS */;
/*!40000 ALTER TABLE `opsz_kosten` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opsz_kosten_permissions`
--

DROP TABLE IF EXISTS `opsz_kosten_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opsz_kosten_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keymachine` varchar(40) DEFAULT NULL,
  `keyreadable` varchar(255) DEFAULT NULL,
  `realid` decimal(6,3) DEFAULT NULL,
  `typelist` varchar(40) DEFAULT NULL,
  `edittype` varchar(60) DEFAULT NULL,
  `defaultvalue` text DEFAULT NULL,
  `referencetag` varchar(40) DEFAULT NULL,
  `role_0` int(11) DEFAULT 0,
  `restrictrole_0` text DEFAULT NULL,
  `role_1` int(11) DEFAULT 0,
  `restrictrole_1` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 `ENCRYPTED`=YES;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opsz_kosten_permissions`
--

LOCK TABLES `opsz_kosten_permissions` WRITE;
/*!40000 ALTER TABLE `opsz_kosten_permissions` DISABLE KEYS */;
INSERT INTO `opsz_kosten_permissions` VALUES (1,'changedat','_none_',1.000,'TIMESTAMP','NONE',NULL,'_none_',0,NULL,0,NULL),(2,'changedby','_none_',2.000,'VARCHAR(40)','NONE',NULL,'_none_',0,NULL,0,NULL),(3,'zweck','Antragszweck',3.000,'VARCHAR(40)','LIST',NULL,'_zweck',0,NULL,0,NULL),(4,'antragsdatum','Antragsdatum',4.000,'DATE','DATE',NULL,NULL,0,NULL,0,NULL),(5,'entscheid','Entscheid',5.000,'VARCHAR(40)','LIST',NULL,'_binary',0,NULL,0,NULL),(6,'widerspruch','Widerspruch',6.000,'VARCHAR(40)','LIST',NULL,'_widerspruch',0,NULL,0,NULL),(7,'widerspruchsdatum','Widerspruchsdatum',7.000,'DATE','DATE',NULL,NULL,0,NULL,0,NULL),(8,'widerspruchsentscheid','Widerspruchsentscheid',8.000,'VARCHAR(40)','LIST',NULL,'_binary',0,NULL,0,NULL),(9,'klage','Klage',9.000,'VARCHAR(40)','LIST',NULL,'_klage',0,NULL,0,NULL),(10,'klagedatum','Klagedatum',10.000,'DATE','DATE',NULL,NULL,0,NULL,0,NULL),(11,'klageentscheid','Klageentscheid',11.000,'VARCHAR(40)','LIST',NULL,'_binary',0,NULL,0,NULL),(12,'code','Code',0.100,'VARCHAR(8)','ID','(REPLACE(REPLACE(REPLACE(upper(LEFT(to_base64(UNHEX(sha1(CONCAT(NOW(),RAND())))),8)),\'/\',\'1\'),\'+\',\'2\'),\'=\',\'3\'))',NULL,6,NULL,0,NULL);
/*!40000 ALTER TABLE `opsz_kosten_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opsz_kosten_references`
--

DROP TABLE IF EXISTS `opsz_kosten_references`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opsz_kosten_references` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referencetag` varchar(40) DEFAULT NULL,
  `depends_on_key` varchar(80) DEFAULT NULL,
  `depends_on_value` varchar(80) DEFAULT NULL,
  `allowed_values` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 `ENCRYPTED`=YES;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opsz_kosten_references`
--

LOCK TABLES `opsz_kosten_references` WRITE;
/*!40000 ALTER TABLE `opsz_kosten_references` DISABLE KEYS */;
INSERT INTO `opsz_kosten_references` VALUES (1,'_none_',NULL,NULL,NULL),(2,'_binary',NULL,NULL,'[\"-\",\"bewilligt\",\"abgelehnt\"]'),(3,'_widerspruch',NULL,NULL,'[\"-\"]'),(4,'_klage',NULL,NULL,'[\"-\"]'),(5,'_zweck',NULL,NULL,'[\"Psychiater\",\"Psychotherapie\",\"Dolmetscherkosten\"]'),(6,'_widerspruch','entscheid','abgelehnt','[\"-\",\"eingelegt\"]'),(7,'_klage','widerspruchsentscheid','abgelehnt','[\"-\",\"eingereicht\"]');
/*!40000 ALTER TABLE `opsz_kosten_references` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opsz_termine`
--

DROP TABLE IF EXISTS `opsz_termine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opsz_termine` (
  `id_opsz_termine` int(11) NOT NULL AUTO_INCREMENT,
  `changedat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `changedby` int(11) DEFAULT NULL,
  `id_opsz_aufnahme` int(11) DEFAULT NULL,
  `id_opsz_db` int(11) DEFAULT NULL,
  `id_os_calendars` int(11) DEFAULT NULL,
  `id_opsz_kosten` int(11) DEFAULT NULL,
  `beginn` datetime DEFAULT NULL,
  `ende` datetime DEFAULT NULL,
  `bei` varchar(40) DEFAULT NULL,
  `dolmetscher` varchar(40) DEFAULT NULL,
  `titel` varchar(40) DEFAULT NULL,
  `protokoll` text DEFAULT NULL,
  `id_opsz_vermittlungslisten` int(11) DEFAULT NULL,
  `typ` varchar(20) DEFAULT NULL,
  `beiadresse` text DEFAULT NULL,
  `code` varchar(8) DEFAULT replace(replace(replace(ucase(left(to_base64(unhex(sha(concat(current_timestamp(),rand())))),8)),'/','1'),'+','2'),'=','3'),
  PRIMARY KEY (`id_opsz_termine`)
) ENGINE=InnoDB AUTO_INCREMENT=3001 DEFAULT CHARSET=utf8mb4 `ENCRYPTED`=YES;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opsz_termine`
--

LOCK TABLES `opsz_termine` WRITE;
/*!40000 ALTER TABLE `opsz_termine` DISABLE KEYS */;
/*!40000 ALTER TABLE `opsz_termine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opsz_termine_permissions`
--

DROP TABLE IF EXISTS `opsz_termine_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opsz_termine_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keymachine` varchar(40) DEFAULT NULL,
  `keyreadable` varchar(255) DEFAULT NULL,
  `realid` decimal(6,3) DEFAULT NULL,
  `typelist` varchar(40) DEFAULT NULL,
  `edittype` varchar(60) DEFAULT NULL,
  `defaultvalue` text DEFAULT NULL,
  `referencetag` varchar(40) DEFAULT NULL,
  `role_0` int(11) DEFAULT 0,
  `restrictrole_0` text DEFAULT NULL,
  `role_1` int(11) DEFAULT 0,
  `restrictrole_1` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 `ENCRYPTED`=YES;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opsz_termine_permissions`
--

LOCK TABLES `opsz_termine_permissions` WRITE;
/*!40000 ALTER TABLE `opsz_termine_permissions` DISABLE KEYS */;
INSERT INTO `opsz_termine_permissions` VALUES (1,'changedat','_none_',1.000,'TIMESTAMP','NONE',NULL,'_none_',0,NULL,0,NULL),(2,'changedby','_none_',2.000,'VARCHAR(40)','NONE',NULL,'_none_',0,NULL,0,NULL),(3,'beginn','Beginn',3.000,'DATETIME','DATETIME',NULL,'_none_',0,NULL,0,NULL),(4,'ende','Ende',4.000,'DATETIME','DATETIME',NULL,'_none_',0,NULL,0,NULL),(5,'bei','bei',5.000,'VARCHAR(40)','EXTENSIBLE LIST',NULL,NULL,0,NULL,0,NULL),(6,'titel','kurze Beschreibung',6.000,'VARCHAR(40)','TEXT',NULL,'_none_',0,NULL,0,NULL),(7,'protokoll','Protokoll',7.000,'TEXT','EDITOR',NULL,'_none_',0,NULL,0,NULL),(9,'dolmetscher','Dolmetscher',5.500,'VARCHAR(40)','TEXT',NULL,NULL,0,NULL,0,NULL),(10,'typ','Art',2.500,'VARCHAR(20)','LIST',NULL,'_termineart',0,NULL,0,NULL),(11,'beiadresse','ggf. Details (Adresse)',5.200,'TEXT','TEXT',NULL,NULL,0,NULL,0,NULL),(12,'code','Code',0.100,'VARCHAR(8)','ID','(REPLACE(REPLACE(REPLACE(upper(LEFT(to_base64(UNHEX(sha1(CONCAT(NOW(),RAND())))),8)),\'/\',\'1\'),\'+\',\'2\'),\'=\',\'3\'))',NULL,6,NULL,0,NULL);
/*!40000 ALTER TABLE `opsz_termine_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opsz_termine_references`
--

DROP TABLE IF EXISTS `opsz_termine_references`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opsz_termine_references` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referencetag` varchar(40) DEFAULT NULL,
  `depends_on_key` varchar(80) DEFAULT NULL,
  `depends_on_value` varchar(80) DEFAULT NULL,
  `allowed_values` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 `ENCRYPTED`=YES;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opsz_termine_references`
--

LOCK TABLES `opsz_termine_references` WRITE;
/*!40000 ALTER TABLE `opsz_termine_references` DISABLE KEYS */;
INSERT INTO `opsz_termine_references` VALUES (1,'_none_',NULL,NULL,NULL),(3,'_termintyp',NULL,NULL,'[\"OS\",\"fest\"]'),(4,'_termineart',NULL,NULL,'[\"OS\",\"Einzelgespräch\",\"Vermittlung\",\"Frauengruppe\",\"Männergruppe\",\"Freizeitgruppe\",\"PMR\",\"*Sonstiges\"]');
/*!40000 ALTER TABLE `opsz_termine_references` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opsz_vermittlungslisten`
--

DROP TABLE IF EXISTS `opsz_vermittlungslisten`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opsz_vermittlungslisten` (
  `id_opsz_vermittlungslisten` int(11) NOT NULL AUTO_INCREMENT,
  `changedat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `changedby` int(11) DEFAULT NULL,
  `id_opsz_aufnahme` int(11) DEFAULT NULL,
  `id_opsz_termine` int(11) DEFAULT NULL,
  `id_opsz_db` int(11) DEFAULT NULL,
  `id_os_calendars` int(11) DEFAULT NULL,
  `id_opsz_kosten` int(11) DEFAULT NULL,
  `listentyp` varchar(20) DEFAULT NULL,
  `auflisteseit` date DEFAULT NULL,
  `code` varchar(8) DEFAULT replace(replace(replace(ucase(left(to_base64(unhex(sha(concat(current_timestamp(),rand())))),8)),'/','1'),'+','2'),'=','3'),
  PRIMARY KEY (`id_opsz_vermittlungslisten`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 `ENCRYPTED`=YES;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opsz_vermittlungslisten`
--

LOCK TABLES `opsz_vermittlungslisten` WRITE;
/*!40000 ALTER TABLE `opsz_vermittlungslisten` DISABLE KEYS */;
/*!40000 ALTER TABLE `opsz_vermittlungslisten` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opsz_vermittlungslisten_permissions`
--

DROP TABLE IF EXISTS `opsz_vermittlungslisten_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opsz_vermittlungslisten_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keymachine` varchar(40) DEFAULT NULL,
  `keyreadable` varchar(255) DEFAULT NULL,
  `realid` decimal(6,3) DEFAULT NULL,
  `typelist` varchar(40) DEFAULT NULL,
  `edittype` varchar(60) DEFAULT NULL,
  `defaultvalue` text DEFAULT NULL,
  `referencetag` varchar(40) DEFAULT NULL,
  `role_0` int(11) DEFAULT 0,
  `restrictrole_0` text DEFAULT NULL,
  `role_1` int(11) DEFAULT 0,
  `restrictrole_1` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 `ENCRYPTED`=YES;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opsz_vermittlungslisten_permissions`
--

LOCK TABLES `opsz_vermittlungslisten_permissions` WRITE;
/*!40000 ALTER TABLE `opsz_vermittlungslisten_permissions` DISABLE KEYS */;
INSERT INTO `opsz_vermittlungslisten_permissions` VALUES (1,'changedat','_none_',1.000,'TIMESTAMP','NONE',NULL,'_none_',0,NULL,0,NULL),(2,'changedby','_none_',2.000,'VARCHAR(40)','NONE',NULL,'_none_',0,NULL,0,NULL),(3,'listentyp','Liste',3.000,'VARCHAR(20)','LIST',NULL,'_listentyp',0,NULL,0,NULL),(4,'auflisteseit','seit',4.000,'DATE','DATE',NULL,NULL,0,NULL,0,NULL),(5,'code','Code',0.100,'VARCHAR(8)','ID','(REPLACE(REPLACE(REPLACE(upper(LEFT(to_base64(UNHEX(sha1(CONCAT(NOW(),RAND())))),8)),\'/\',\'1\'),\'+\',\'2\'),\'=\',\'3\'))',NULL,6,NULL,0,NULL);
/*!40000 ALTER TABLE `opsz_vermittlungslisten_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opsz_vermittlungslisten_references`
--

DROP TABLE IF EXISTS `opsz_vermittlungslisten_references`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opsz_vermittlungslisten_references` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referencetag` varchar(40) DEFAULT NULL,
  `depends_on_key` varchar(80) DEFAULT NULL,
  `depends_on_value` varchar(80) DEFAULT NULL,
  `allowed_values` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 `ENCRYPTED`=YES;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opsz_vermittlungslisten_references`
--

LOCK TABLES `opsz_vermittlungslisten_references` WRITE;
/*!40000 ALTER TABLE `opsz_vermittlungslisten_references` DISABLE KEYS */;
INSERT INTO `opsz_vermittlungslisten_references` VALUES (1,'_none_',NULL,NULL,NULL),(2,'_listentyp',NULL,NULL,'[\"Psychiater\",\"Psychotherapeut\"]');
/*!40000 ALTER TABLE `opsz_vermittlungslisten_references` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `os_functions`
--

LOCK TABLES `os_functions` WRITE;
/*!40000 ALTER TABLE `os_functions` DISABLE KEYS */;
INSERT INTO `os_functions` (iconname,functionmachine,functionreadable,functionscope,functionclasses,allowed_roles,functiontarget) VALUES ('traffic-light','trafficLight','Ampel','TABLES',NULL,'[0]','important'),('comment-dots','printDB','Erzeuge DB','TABLES','details printdb','[6]','_popup_');
/*!40000 ALTER TABLE `os_functions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `os_tables`
--

LOCK TABLES `os_tables` WRITE;
/*!40000 ALTER TABLE `os_tables` DISABLE KEYS */;
INSERT INTO `os_tables` VALUES (2,'address-card','opsz_aufnahme','Aufnahme','[0,6]','[6]',NULL),(4,'calendar-alt','opsz_termine','Dokumentation und Termine','[0,6]','[6]',NULL),(5,'comments','opsz_db','Dienstbesprechung','[0,6]','[6]','[\"opsz_aufnahme__verantwortlich\",\"opsz_aufnahme__name\",\"opsz_aufnahme__vorname\",\"opsz_aufnahme__herkunft\",\"opsz_aufnahme__geburtsdatum\",\"opsz_aufnahme__landkreisregion\",\"opsz_dokumentation__diagnose\"]'),(6,'calendar-check','os_calendars','Kalenderserver','[0,6]',NULL,NULL),(7,'hand-holding-usd','opsz_kosten','Kostenübernahme','[6]','[6]',NULL),(8,'clipboard-list','opsz_vermittlungslisten','Vermittlungsliste','[6]','[6]',NULL);
/*!40000 ALTER TABLE `os_tables` ENABLE KEYS */;
UNLOCK TABLES;

-- Dump completed on 2020-05-03 14:42:00

