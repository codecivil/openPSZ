-- transfer "nächster Termin" from opsz_aufnahme to opsz_termine
ALTER TABLE `opsz_termine` ADD COLUMN `naechstertermin` DATETIME DEFAULT NULL;
ALTER TABLE `opsz_aufnahme` DROP COLUMN `naechstertermin`;
INSERT  INTO `opsz_termine_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`role_0`) SELECT 'naechstertermin','nächster Termin','8.0','DATETIME','DATETIME','0' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_termine' AND COLUMN_NAME = 'naechstertermin') > 0 AND (SELECT count(keymachine) FROM `opsz_termine_permissions` where keymachine = 'naechstertermin') = 0;
DELETE FROM `opsz_aufnahme_permissions` WHERE `keymachine` = 'naechstertermin';
