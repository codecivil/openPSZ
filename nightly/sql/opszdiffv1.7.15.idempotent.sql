-- Vermittlungsänderungen --

-- Termine und Dok --
UPDATE `opsz_termine_permissions`SET `typelist`= 'TEXT',`edittype`= 'FREE' WHERE `keymachine`= 'dolmetscher';

-- Vermittlungsliste --
UPDATE `os_tables`SET `displayforeign`= '["opsz_aufnahme__verantwortlich","opsz_aufnahme__name","opsz_aufnahme__vorname","opsz_aufnahme__adresse","opsz_aufnahme__muttersprache","opsz_aufnahme__sprachkenntnisse","opsz_aufnahme__genderaspekte","opsz_aufnahme__gesundheitsversorgung","opsz_aufnahme__lebensunterhalt","opsz_aufnahme__swes","opsz_aufnhame__hausarzt","opsz_aufnahme__diagnoseexternkombi","opsz_aufnahme__symptomatik"]' WHERE `tablemachine`= 'opsz_vermittlungslisten';
ALTER TABLE `opsz_vermittlungslisten` ADD COLUMN `befundbericht` TEXT DEFAULT NULL;
INSERT  INTO `opsz_vermittlungslisten_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`referencetag`) SELECT 'befundbericht','Befundbericht: vorhanden + erstellt von','10.1','TEXT','LIST + TEXT; MULTIPLE','_yesno + _bberstelltvon' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_vermittlungslisten' AND COLUMN_NAME = 'befundbericht') > 0 AND (SELECT count(keymachine) FROM `opsz_vermittlungslisten_permissions` where keymachine = 'befundbericht') = 0;
INSERT  INTO `opsz_vermittlungslisten_references` (`referencetag`,`allowed_values`) VALUES ('_bberstelltvon','["_HIDE_"]');
INSERT  INTO `opsz_vermittlungslisten_references` (`referencetag`,`depends_on_key`,`depends_on_value`,`allowed_values`) VALUES ('_bberstelltvon','befundbericht[0];local','ja','["_SHOW_"]');
ALTER TABLE `opsz_vermittlungslisten` ADD COLUMN `genauerauftrag` TEXT DEFAULT NULL;
INSERT  INTO `opsz_vermittlungslisten_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`) SELECT 'genauerauftrag','genauer Auftrag','6.5','TEXT','FREE' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_vermittlungslisten' AND COLUMN_NAME = 'genauerauftrag') > 0 AND (SELECT count(keymachine) FROM `opsz_vermittlungslisten_permissions` where keymachine = 'genauerauftrag') = 0;
ALTER TABLE `opsz_vermittlungslisten` ADD COLUMN `prio` VARCHAR(20) DEFAULT NULL;
INSERT  INTO `opsz_vermittlungslisten_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`referencetag`) SELECT 'prio','Priorität','5.5','VARCHAR(20)','LIST','_prio' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_vermittlungslisten' AND COLUMN_NAME = 'prio') > 0 AND (SELECT count(keymachine) FROM `opsz_vermittlungslisten_permissions` where keymachine = 'prio') = 0;
INSERT  INTO `opsz_vermittlungslisten_references` (`referencetag`,`allowed_values`) VALUES ('_prio','["niedrig","*mittel","hoch"]');
ALTER TABLE `opsz_vermittlungslisten` ADD COLUMN `hinweisung` VARCHAR(40) DEFAULT NULL;
INSERT  INTO `opsz_vermittlungslisten_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`referencetag`) SELECT 'hinweisung','hingewiesen auf','10.3','VARCHAR(40)','LIST; MULTIPLE','_hinweisung' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_vermittlungslisten' AND COLUMN_NAME = 'hinweisung') > 0 AND (SELECT count(keymachine) FROM `opsz_vermittlungslisten_permissions` where keymachine = 'hinweisung') = 0;
INSERT  INTO `opsz_vermittlungslisten_references` (`referencetag`,`allowed_values`) VALUES ('_hinweisung','["-","Blutbild/EKG","reguläre Überweisung","Hausarztvermittlungsfall"]');
UPDATE `opsz_vermittlungslisten_references`SET `allowed_values`= '["*nicht anwendbar","Erstantrag","Folgeantrag","Widerspruch"]' WHERE `referencetag`= '_verfahrensstand';
INSERT  INTO `opsz_vermittlungslisten_references` (`referencetag`,`allowed_values`) VALUES ('_trinary','["*zu klären","ja","nein"]');
ALTER TABLE `opsz_vermittlungslisten` ADD COLUMN `kvn` VARCHAR(20) DEFAULT NULL;
INSERT  INTO `opsz_vermittlungslisten_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`referencetag`) SELECT 'kvn','KVN-Servicestelle','12.5','VARCHAR(20)','LIST','_trinary' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_vermittlungslisten' AND COLUMN_NAME = 'kvn') > 0 AND (SELECT count(keymachine) FROM `opsz_vermittlungslisten_permissions` where keymachine = 'kvn') = 0;
ALTER TABLE `opsz_vermittlungslisten` ADD COLUMN `kontakt` VARCHAR(20) DEFAULT NULL;
INSERT  INTO `opsz_vermittlungslisten_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`referencetag`) SELECT 'kontakt','Kontaktaufnahme über / Bezugsperson','12.7','VARCHAR(20)','CHECKBOX','_kontakt' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_vermittlungslisten' AND COLUMN_NAME = 'kontakt') > 0 AND (SELECT count(keymachine) FROM `opsz_vermittlungslisten_permissions` where keymachine = 'kontakt') = 0;
INSERT  INTO `opsz_vermittlungslisten_references` (`referencetag`,`allowed_values`) VALUES ('_kontakt','["*Selbst","Ehepartner","Kinder","Unterstützer","Betreuer","Sozialarbeiter","Sonstige"]');
ALTER TABLE `opsz_vermittlungslisten` ADD COLUMN `kontaktdaten` TEXT DEFAULT NULL;
INSERT  INTO `opsz_vermittlungslisten_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`) SELECT 'kontaktdaten','Kontaktdaten / Bemerkungen','12.8','TEXT','FREE' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_vermittlungslisten' AND COLUMN_NAME = 'kontaktdaten') > 0 AND (SELECT count(keymachine) FROM `opsz_vermittlungslisten_permissions` where keymachine = 'kontaktdaten') = 0;

-- Einträge Zweitantrag wird zu Folgeantrag
UPDATE opsz_vermittlungslisten set therapieantrag = REPLACE(therapieantrag,"Zweitantrag","Folgeantrag");
UPDATE opsz_vermittlungslisten set dolmetscherinnenantrag = REPLACE(dolmetscherinnenantrag,"Zweitantrag","Folgeantrag");
UPDATE opsz_vermittlungslisten set fahrtkostenantrag = REPLACE(fahrtkostenantrag,"Zweitantrag","Folgeantrag");
