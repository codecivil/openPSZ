-- add fields in opsz_aufnahme
-- beratungsangaben
ALTER TABLE `opsz_aufnahme` ADD COLUMN IF NOT EXISTS `beratungsangaben` TEXT DEFAULT NULL;
INSERT  INTO `opsz_aufnahme_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`referencetag`,`role_0`) VALUES ('beratungsangaben','Angaben zu Beratungsstellen','31.100','TEXT','LIST + FREE; MULTIPLE','_beratungstyp','0');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`allowed_values`) VALUES ('_beratungstyp','["*Andere Beratungsstellen","Migrationsberatung","Rechtsanwält*in","Unterstützer*in","Familienhilfe"]');
-- mobilität
UPDATE `opsz_aufnahme_permissions`SET `keyreadable`= 'Mobilität - veraltet (bitte neues Feld benutzen)' WHERE `keymachine`= 'mobilität';
ALTER TABLE `opsz_aufnahme` ADD COLUMN IF NOT EXISTS `mobilitätneu` TEXT DEFAULT NULL;
-- -- edittype MULTIPLE is not set here: make updateSelections work with that!
INSERT  INTO `opsz_aufnahme_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`referencetag`,`role_0`) VALUES ('mobilitätneu','Mobilität',25.100,'TEXT','CHECKBOX','_mobilitaet','0');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`allowed_values`) VALUES ('_mobilitaet','["ÖPNV","Auto","Fahrrad","zu Fuß"]');
ALTER TABLE `opsz_aufnahme` ADD COLUMN IF NOT EXISTS `videogespraeche` VARCHAR(10) DEFAULT NULL;
INSERT  INTO `opsz_aufnahme_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`referencetag`,`role_0`) VALUES ('videogespraeche','Videogespräche erwünscht','25.2','VARCHAR(10)','LIST','_binary','0');
-- messenger
ALTER TABLE `opsz_aufnahme` ADD COLUMN IF NOT EXISTS `messenger` TEXT DEFAULT NULL;
INSERT  INTO `opsz_aufnahme_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`referencetag`,`role_0`) VALUES ('messenger','Messenger-Erstkontakt erwünscht?: _ + unterschrieben + Messenger + Telefonnummer (falls abweichend)',14.5,'TEXT','LIST + LIST + LIST + PHONE; MULTIPLE','_binary + _messenger_binary + _messengers + _messenger_phone','0','0','0','0','0','0','0',?);
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`allowed_values`) VALUES ('_messenger_binary','["_HIDE_"]');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`depends_on_key`,`depends_on_value`,`allowed_values`) VALUES ('_messenger_binary','messenger[0];local','ja','["*zu klären","ja","nein","_SHOW_"]');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`allowed_values`) VALUES ('_messengers','["_HIDE_"]');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`depends_on_key`,`depends_on_value`,`allowed_values`) VALUES ('_messengers','messenger[0];local','ja','["*WhatsApp","Signal","Facebook","WeChat","Snapchat","Telegram","QQ","Matrix","_SHOW_"]');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`allowed_values`) VALUES ('_messenger_phone','["_HIDE_"]');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`depends_on_key`,`depends_on_value`,`allowed_values`) VALUES ('_messenger_phone','messenger[0];local','ja','["_SHOW_"]');
-- arztangeban
ALTER TABLE `opsz_aufnahme` ADD COLUMN IF NOT EXISTS `arztangaben` TEXT DEFAULT NULL;
INSERT  INTO `opsz_aufnahme_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`referencetag`,`role_0`) VALUES ('arztangaben','Angaben zu Ärzt*innen: Kategorie + Kontakt','19.1','TEXT','LIST + FREE; MULTIPLE','_arzttyp + _arztkontakt','0');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`allowed_values`) VALUES ('_arzttyp','["*keine Angaben","Hausärzt*in","Psychiater*in","Neurolog*in","Frauenärzt*in","~andere Ärzt*innen"]');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`allowed_values`) VALUES ('_arztkontakt','["_SHOW_"]');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`depends_on_key`,`depends_on_value`,`allowed_values`) VALUES ('_arztkontakt','arztangaben[0];local','*keine Angaben','["_HIDE_"]');
-- behinderung
ALTER TABLE `opsz_aufnahme` ADD COLUMN IF NOT EXISTS `behinderung` VARCHAR(10) DEFAULT NULL;
INSERT  INTO `opsz_aufnahme_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`referencetag`,`role_0`) VALUES ('behinderung','Liegt eine Behinderung vor?',26.5,'VARCHAR(10)','LIST','_binary','0');
-- update lebensunterhalt
UPDATE `opsz_aufnahme_references` SET `allowed_values` = '["*zu klären","Sozialamt","Jobcenter","Arbeit","~Sonstiges"]' WHERE `referencetag` = '_lebensunterhalt';
-- update Angaben zu Kindern -> Angaben zu Familienangehörigen
UPDATE `opsz_aufnahme_permissions` SET `keyreadable`= 'Angaben zu Familienangehörigen',`edittype`='FREE' WHERE `keymachine`= 'kinderdetail';
UPDATE `opsz_aufnahme_permissions` SET `edittype`= 'NONE' WHERE `keymachine`= 'kinder';
UPDATE `opsz_aufnahme` SET kinderdetail = NULLIF(CONCAT(COALESCE(CONCAT('Kinder: ',kinder, ', '),''), COALESCE(kinderdetail,'')),'') FROM opsz_aufnahme;

-- Reencode Ärztinnen data
UPDATE opsz_aufnahme SET arztangaben = '[[],[]]';
UPDATE opsz_aufnahme set arztangaben = JSON_SET(JSON_SET(arztangaben,'$[0]',JSON_ARRAY_APPEND(JSON_QUERY(arztangaben,'$[0]'),'$','Hausärzt*in')),'$[1]',JSON_ARRAY_APPEND(JSON_QUERY(arztangaben,'$[1]'),'$',hausarzt)) WHERE NOT hausarzt IS NULL;
UPDATE opsz_aufnahme set arztangaben = JSON_SET(JSON_SET(arztangaben,'$[0]',JSON_ARRAY_APPEND(JSON_QUERY(arztangaben,'$[0]'),'$','Psychiater*in')),'$[1]',JSON_ARRAY_APPEND(JSON_QUERY(arztangaben,'$[1]'),'$',psychiater)) WHERE NOT psychiater IS NULL;
UPDATE opsz_aufnahme set arztangaben = JSON_SET(JSON_SET(arztangaben,'$[0]',JSON_ARRAY_APPEND(JSON_QUERY(arztangaben,'$[0]'),'$','~andere Ärzt*innen')),'$[1]',JSON_ARRAY_APPEND(JSON_QUERY(arztangaben,'$[1]'),'$',CONCAT('Psychotherapeut*in: ',psychotherapeut))) WHERE NOT psychotherapeut IS NULL;
UPDATE opsz_aufnahme SET arztangaben = '[[""],[""]]' WHERE arztangaben = '[[],[]]';

-- Reencode Beratungsstellen data
UPDATE opsz_aufnahme SET beratungsangaben = '[[],[]]';
UPDATE opsz_aufnahme set beratungsangaben = JSON_SET(JSON_SET(beratungsangaben,'$[0]',JSON_ARRAY_APPEND(JSON_QUERY(beratungsangaben,'$[0]'),'$','Rechtsanwält*in')),'$[1]',JSON_ARRAY_APPEND(JSON_QUERY(beratungsangaben,'$[1]'),'$',rechtsanwalt)) WHERE NOT rechtsanwalt IS NULL;
UPDATE opsz_aufnahme set beratungsangaben = JSON_SET(JSON_SET(beratungsangaben,'$[0]',JSON_ARRAY_APPEND(JSON_QUERY(beratungsangaben,'$[0]'),'$','Unterstützer*in')),'$[1]',JSON_ARRAY_APPEND(JSON_QUERY(beratungsangaben,'$[1]'),'$',unterstuetzer)) WHERE NOT unterstuetzer IS NULL;
UPDATE opsz_aufnahme set beratungsangaben = JSON_SET(JSON_SET(beratungsangaben,'$[0]',JSON_ARRAY_APPEND(JSON_QUERY(beratungsangaben,'$[0]'),'$','Familienhilfe')),'$[1]',JSON_ARRAY_APPEND(JSON_QUERY(beratungsangaben,'$[1]'),'$',familienhilfe)) WHERE NOT familienhilfe IS NULL;
UPDATE opsz_aufnahme set beratungsangaben = JSON_SET(JSON_SET(beratungsangaben,'$[0]',JSON_ARRAY_APPEND(JSON_QUERY(beratungsangaben,'$[0]'),'$','*Andere Beratungsstellen')),'$[1]',JSON_ARRAY_APPEND(JSON_QUERY(beratungsangaben,'$[1]'),'$',beratungsstellen)) WHERE NOT beratungsstellen IS NULL;
UPDATE opsz_aufnahme SET beratungsangaben = '[[""],[""]]' WHERE beratungsangaben = '[[],[]]';

-- set edittype to NONE for hausarzt, psychiater, psychotherapeut, rechtsanwalt, unterstuetzer, familienhilfe
-- keep data temporarily; if everything is ok delete the fields in next update
UPDATE `opsz_aufnahme_permissions` SET `edittype`= 'NONE' WHERE `keymachine` in ('beratungsstellen','hausarzt','psychiater','psychotherapeut','rechtsanwalt','unterstuetzer','familienhilfe');
