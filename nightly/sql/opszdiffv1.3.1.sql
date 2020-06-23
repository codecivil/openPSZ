INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype,referencetag) VALUES ('krankenhausaufenthalt','psychiatrischer Krankenhausaufenthalt',24.1,'VARCHAR(8)','LIST','_yesno');
ALTER TABLE opsz_aufnahme ADD COLUMN `krankenhausaufenthalt` VARCHAR(8);

INSERT INTO opsz_termine_permissions (keymachine,keyreadable,realid,typelist,edittype,referencetag) VALUES ('swe_beratungsstellen','SWE (Beratungsstellen) liegt vor',31.5,'VARCHAR(10)','LIST','_swe');
ALTER TABLE opsz_aufnahme ADD COLUMN `swe_beratungsstellen` VARCHAR(10);

INSERT INTO opsz_termine_permissions (keymachine,keyreadable,realid,typelist,edittype,referencetag) VALUES ('swe_psychotherapeut','SWE (PsychotherapeutIn) liegt vor',24.6,'VARCHAR(10)','LIST','_swe');
ALTER TABLE opsz_aufnahme ADD COLUMN `swe_psychotherapeut` VARCHAR(10);

INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype) VALUES ('psychotherapeut','PsychotherapeutIn (Kontaktdaten)',24.3,'TEXT','FREE');
ALTER TABLE opsz_aufnahme ADD COLUMN `psychotherapeut` TEXT;

INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype,referencetag) VALUES ('ausweiskopievorhanden','Ausweiskopie vorhanden',33.5,'VARCHAR(8)','LIST','_yesno');
ALTER TABLE opsz_aufnahme ADD COLUMN `ausweiskopievorhanden` VARCHAR(8);

INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype) VALUES ('muttersprache','Muttersprache',7.5,'TEXT','EXTENSIBLE LIST');
ALTER TABLE opsz_aufnahme ADD COLUMN `muttersprache` TEXT;

INSERT INTO opsz_termine_references (referencetag,allowed_values) VALUES ('_terminstattgefunden','["*ja","Absage KlientIn","Absage PSZ","KlientIn nicht erschienen"]');

UPDATE opsz_aufnahme_permissions SET edittype='LIST' WHERE keymachine='anfragevon';
UPDATE opsz_aufnahme_permissions SET edittype='LIST' WHERE keymachine='aufenthaltsstatus';
UPDATE opsz_aufnahme_permissions SET edittype='LIST' WHERE keymachine='aufenthaltorig';
UPDATE opsz_aufnahme_permissions SET keyreadable = 'Beratungsstellen (Kontaktdaten)' WHERE keymachine = 'beratungsstellen';
UPDATE opsz_aufnahme_permissions SET keyreadable = 'UnterstützerIn/Angehörige (Kontaktdaten)' WHERE keymachine = 'unterstuetzer';
UPDATE opsz_aufnahme_permissions SET keyreadable = 'Familienhilfe/Vormundschaft (Kontaktdaten)' WHERE keymachine = 'familienhilfe';
UPDATE opsz_aufnahme_permissions SET keyreadable = 'DolmetscherIn' WHERE keymachine = 'dolmetscher';
UPDATE opsz_aufnahme_permissions SET keyreadable = 'Sprachkenntnisse' WHERE keymachine = 'sprache';
UPDATE opsz_aufnahme_references SET allowed_values='["*zu klären", "Aufenthaltserlaubnis","Aufenthaltsgestattung","Duldung","Duldung light","Grenzübertrittsbescheinigung","Ausländerbehördliche Bescheinigung","Fiktionsbescheinigung","Ankunftsnachweis","Visum","EU-Bürger","Ohne Papiere"]' WHERE referencetag='_aufenthaltsstatus';
UPDATE opsz_aufnahme_references SET allowed_values='["*zu klären","Folteropfer","sonstige Formen sexueller, psychischer, physischer Gewalt","Opfer von Menschenhandel","FGM","Ü 60","U 18","umF","Alleinerziehend mit minderjährigen Kindern","Personen mit psychischen Störungen","LSBTTIQ*","Menschen mit Behinderung","Personen mit schweren körperlichen Erkrankungen"]' WHERE referencetag='_vulnerabilitaet';
