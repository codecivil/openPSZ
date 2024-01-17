-- Funktionsfeld "e-Mail an Klientin" in Termine
ALTER TABLE `opsz_termine` ADD COLUMN `emailonchange` TEXT DEFAULT NULL;
INSERT INTO `opsz_termine_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`referencetag`) SELECT 'emailonchange','Termin(-änderung) an KlientIn emailen','5.25','TEXT','FUNCTION; CHECKED','_emailonchange' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_termine' AND COLUMN_NAME = 'emailonchange') > 0 AND (SELECT count(keymachine) FROM `opsz_termine_permissions` where keymachine = 'emailonchange') = 0;
INSERT INTO `opsz_termine_references` (`referencetag`,`depends_on_key`,`allowed_values`) VALUES ('_emailonchange','beginn','["emailTo(clientTermin)"]');
INSERT INTO `opsz_termine_references` (`referencetag`,`depends_on_key`,`allowed_values`) VALUES ('_emailonchange','beiadresse','["emailTo(clientTermin)"]');

--Konfiguration der Funktion emailTo ist kundenspezifisch
