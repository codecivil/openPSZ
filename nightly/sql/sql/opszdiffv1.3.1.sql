-- here: template for conditional insert; in order to make it unipotent
-- ALTER TABLE opsz_aufnahme ADD COLUMN `swe_beratungsstellen` VARCHAR(10);
-- INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype,referencetag) SELECT 'swe_beratungsstellen','SWE (Beratungsstellen) liegt vor',31.5,'VARCHAR(10)','LIST','_swe' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'swe_beratungsstellen') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_permissions` where keymachine = 'swe_beratungsstellen') = 0;
-- do this for every insert below...
ALTER TABLE opsz_aufnahme ADD COLUMN `krankenhausaufenthalt` VARCHAR(8);
INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype,referencetag) SELECT 'krankenhausaufenthalt','psychiatrischer Krankenhausaufenthalt',24.1,'VARCHAR(8)','LIST','_binary' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'krankenhausaufenthalt') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_permissions` where keymachine = 'krankenhausaufenthalt') = 0;

ALTER TABLE opsz_aufnahme ADD COLUMN `swe_beratungsstellen` VARCHAR(10);
INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype,referencetag) SELECT 'swe_beratungsstellen','SWE (Beratungsstellen) liegt vor',31.5,'VARCHAR(10)','LIST','_swe' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'swe_beratungsstellen') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_permissions` where keymachine = 'swe_beratungsstellen') = 0;

ALTER TABLE opsz_aufnahme ADD COLUMN `swe_psychotherapeut` VARCHAR(10);
INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype,referencetag) SELECT 'swe_psychotherapeut','SWE (PsychotherapeutIn) liegt vor',24.6,'VARCHAR(10)','LIST','_swe' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'swe_psychotherapeut') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_permissions` where keymachine = 'swe_psychotherapeut') = 0;

ALTER TABLE opsz_aufnahme ADD COLUMN `psychotherapeut` TEXT;
INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype) SELECT 'psychotherapeut','PsychotherapeutIn (Kontaktdaten)',24.3,'TEXT','FREE' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'psychotherapeut') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_permissions` where keymachine = 'psychotherapeut') = 0;

ALTER TABLE opsz_aufnahme ADD COLUMN `ausweiskopievorhanden` VARCHAR(8);
INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype,referencetag) SELECT 'ausweiskopievorhanden','Ausweiskopie vorhanden',33.5,'VARCHAR(8)','LIST','_yesno' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'ausweiskopievorhanden') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_permissions` where keymachine = 'ausweiskopievorhanden') = 0;

ALTER TABLE opsz_aufnahme ADD COLUMN `muttersprache` TEXT;
INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype) SELECT 'muttersprache','Muttersprache',7.5,'TEXT','EXTENSIBLE LIST' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'muttersprache') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_permissions` where keymachine = 'muttersprache') = 0;

UPDATE opsz_aufnahme_permissions SET edittype='LIST' WHERE keymachine='anfragevon';
UPDATE opsz_aufnahme_permissions SET edittype='LIST' WHERE keymachine='aufenthaltsstatus';
UPDATE opsz_aufnahme_permissions SET edittype='LIST' WHERE keymachine='aufenthaltorig';
UPDATE opsz_aufnahme_permissions SET keyreadable = 'Beratungsstellen (Kontaktdaten)' WHERE keymachine = 'beratungsstellen';
UPDATE opsz_aufnahme_permissions SET keyreadable = 'UnterstützerIn / Angehörige (Kontaktdaten)' WHERE keymachine = 'unterstuetzer';
UPDATE opsz_aufnahme_permissions SET keyreadable = 'Familienhilfe / Vormundschaft (Kontaktdaten)' WHERE keymachine = 'familienhilfe';
UPDATE opsz_aufnahme_permissions SET keyreadable = 'DolmetscherIn' WHERE keymachine = 'dolmetscher';
UPDATE opsz_aufnahme_permissions SET keyreadable = 'Sprachkenntnisse' WHERE keymachine = 'sprache';
UPDATE opsz_aufnahme_references SET allowed_values='["*zu klären", "Aufenthaltserlaubnis","Aufenthaltsgestattung","Duldung","Duldung light","Grenzübertrittsbescheinigung","Ausländerbehördliche Bescheinigung","Fiktionsbescheinigung","Ankunftsnachweis","Visum","EU-Bürger","Ohne Papiere"]' WHERE referencetag='_aufenthaltsstatus';
UPDATE opsz_aufnahme_references SET allowed_values='["*zu klären","Folteropfer","sonstige Formen sexueller, psychischer, physischer Gewalt","Opfer von Menschenhandel","FGM","Ü 60","U 18","umF","Alleinerziehend mit minderjährigen Kindern","Personen mit psychischen Störungen","LSBTTIQ*","Menschen mit Behinderung","Personen mit schweren körperlichen Erkrankungen"]' WHERE referencetag='_vulnerabilitaet';
