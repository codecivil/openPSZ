-- openStatAdmin-log started 01.31.2021 17:15:26
ALTER TABLE `opsz_aufnahme` ADD COLUMN `swes` VARCHAR(40) DEFAULT NULL;
INSERT  INTO `opsz_aufnahme_permissions` (`keymachine`,`keyreadable`,`realid`,`typelist`,`edittype`,`referencetag`) VALUES ('swes','SWE liegt vor','17.8','VARCHAR(40)','LIST; MULTIPLE','_swes');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`allowed_values`) VALUES ('_swes','["HausärztIn","PsychiaterIn","UnterstützerIn","RechtsanwältIn","Krankenvers. und Lebensunterhalt","Familienhilfe","Beratungsstellen","PsychotherapeutIn"]');
-- openStatAdmin-log finished 01.31.2021 17:23:41
