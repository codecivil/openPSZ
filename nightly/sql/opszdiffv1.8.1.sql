-- Alter als EXPRESSION statt VIRTUAL
ALTER TABLE `opsz_aufnahme` DROP COLUMN `age`;
DELETE FROM `opsz_aufnahme_permissions` WHERE keymachine = 'age';
INSERT INTO `opsz_aufnahme_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`defaultvalue`,`role_0`) VALUES ('age','Alter','10.1','INT','INTEGER; EXPRESSION','\'TIMESTAMPDIFF(YEAR,geburtsdatum,CURRENT_TIMESTAMP(0))\'','0');
