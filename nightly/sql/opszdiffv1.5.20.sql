-- edittype and referencetag too short for suizidalitaet
alter table opsz_aufnahme_permissions modify column edittype VARCHAR(100);
alter table opsz_aufnahme_permissions modify column referencetag VARCHAR(100);
-- rename hinweise and push to end of section
UPDATE `opsz_aufnahme_permissions`SET `keymachine`= 'hinweise',`keyreadable`= 'Suizidale Dokumentation bis 1.7.21 - bitte nicht mehr bearbeiten',`realid`= '37.500',`typelist`= 'TEXT',`edittype`= 'EDITOR',`referencetag`= '',`role_0`= '6' WHERE keymachine = 'hinweise';
-- add additional suizid fields
ALTER TABLE `opsz_aufnahme` ADD COLUMN `suizidversuche` TEXT DEFAULT NULL;
INSERT  INTO `opsz_aufnahme_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`referencetag`) VALUES ('suizidversuche','Suizidversuche: Wer + Wann + Wo + Wie','37.2','TEXT','EXTENSIBLE LIST + DATE + TEXT + TEXT; MULTIPLE','_suizidwer');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`allowed_values`) VALUES ('_suizidwer','["***","selbst"]');
ALTER TABLE `opsz_aufnahme` ADD COLUMN `suizidrisikofaktoren` TEXT DEFAULT NULL;
INSERT  INTO `opsz_aufnahme_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`) VALUES ('suizidrisikofaktoren','Sonstige besondere Risikofaktoren','37.3','TEXT','FREE');
ALTER TABLE `opsz_aufnahme` ADD COLUMN `suizidale_absichten` TEXT DEFAULT NULL;
INSERT  INTO `opsz_aufnahme_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`referencetag`) VALUES ('suizidale_absichten','suizidale Absichten: Absicht oder Handlungspläne + Glaubhaft distanziert + Datum + imperative Stimmen + Absprachefähig + Folgende Absprachen wurden getroffen + Aufnahme in Klinik besprochen + Aufnahme in Klinik veranlasst','37.100','TEXT','LIST + LIST + DATE + LIST + LIST + TEXT + TEXT + LIST; MULTIPLE','_suizidalitaet + _suizid_binary + _ + _yesno + _suizid_binary + _ + _ + _yesno');
INSERT INTO `opsz_aufnahme_references` (`referencetag`,`allowed_values`) VALUES ('_suizidalitaet','["0 - keine Hinweise auf Suizidalität","1 - suizidale Gedanken glaubhaft verneint","2 - Passive Todeswünsche","3 - suizidale Gedanken","4 - suizidale Äußerungen","5 - suizidale Absichten","6 - Konkrete Handlungspläne"]');
INSERT INTO `opsz_aufnahme_references` (`referencetag`,`allowed_values`) VALUES ('_suizid_binary','["*zu klären"]');
INSERT INTO `opsz_aufnahme_references` (`referencetag`,`depends_on_key`,`depends_on_value`,`allowed_values`) VALUES ('_suizid_binary','suididale_absichten','5 - suizidale Absichten','["*zu klären","ja","nein"]');
INSERT INTO `opsz_aufnahme_references` (`referencetag`,`depends_on_key`,`depends_on_value`,`allowed_values`) VALUES ('_suizid_binary','suididale_absichten','6 - Konkrete Handlungspläne','["*zu klären","ja","nein"]');
-- "inaktiv seit"-Feld
ALTER TABLE `opsz_aufnahme` ADD COLUMN `inaktivseit` TEXT DEFAULT NULL;
INSERT  INTO `opsz_aufnahme_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`referencetag`) VALUES ('inaktivseit','inaktiv seit: Quartal + Jahr','2.700','TEXT','LIST + LIST; MULTIPLE','_quartal + _jahr');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`depends_on_key`,`depends_on_value`,`allowed_values`) VALUES ('_quartal','aktiv','nein','["Q1","Q2","Q3","Q4"]');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`allowed_values`) VALUES ('_quartal','["-"]');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`depends_on_key`,`depends_on_value`,`allowed_values`) VALUES ('_jahr','aktiv','nein','["2015","2016","2017","2018","2019","2020","2021","2022"]');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`allowed_values`) VALUES ('_jahr','["-"]');
