-- Alter als virtuelles Feld im Aufnahmebogen
ALTER TABLE `opsz_aufnahme` ADD COLUMN `age` INT;
INSERT  INTO `opsz_aufnahme_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`defaultvalue`,`role_0`) VALUES ('age','Alter','10.1','INT','INTEGER; VIRTUAL','\'TIMESTAMPDIFF(YEAR,$geburtsdatum$,CURRENT_TIMESTAMP(0))\'',0);

--Fallverantwortliche(r) MULTIPLE
UPDATE `opsz_aufnahme_permissions`SET `keyreadable`= 'Fallverantwortliche(r): Name + seit',`typelist`= 'TEXT',`edittype`= 'EXTENSIBLE LIST + DATE; MULTIPLE' WHERE `keymachine`= 'verantwortlich';
