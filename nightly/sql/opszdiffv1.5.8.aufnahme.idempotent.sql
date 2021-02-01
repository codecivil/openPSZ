-- openStatAdmin-log started 01.31.2021 17:15:26
ALTER TABLE `opsz_aufnahme` ADD COLUMN `swes` TEXT DEFAULT NULL;
INSERT  INTO `opsz_aufnahme_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`referencetag`) SELECT 'swes','SWE liegt vor','17.8','VARCHAR(40)','LIST; MULTIPLE','_swes' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme_permissions' AND COLUMN_NAME = 'swes') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_permissions` where keymachine = 'swes') = 0;
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`allowed_values`) VALUES ('_swes','["","HausärztIn","PsychiaterIn","UnterstützerIn","RechtsanwältIn","Krankenvers. und Lebensunterhalt","Familienhilfe","Beratungsstellen","PsychotherapeutIn"]');
-- openStatAdmin-log finished 01.31.2021 17:23:41
