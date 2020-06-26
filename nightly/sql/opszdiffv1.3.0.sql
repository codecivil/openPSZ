UPDATE opsz_aufnahme_permissions SET edittype = 'CHECKBOX' WHERE keymachine = 'anzeichendetail';
UPDATE opsz_aufnahme_permissions SET referencetag = '_yesno' WHERE keymachine = 'aufnahmepsz';
UPDATE opsz_aufnahme_permissions SET referencetag = '_yesno' WHERE keymachine = 'listestellungnahme';
UPDATE opsz_aufnahme_permissions SET keyreadable = 'Sprache-Kommentar' WHERE keymachine = 'sprachedetail';
UPDATE opsz_aufnahme_permissions SET keyreadable = 'HausärztIn (Kontaktdaten)' WHERE keymachine = 'hausarzt';
UPDATE opsz_aufnahme_permissions SET keyreadable = 'SWE (HausärztIn)' WHERE keymachine = 'swe_hausarzt';
UPDATE opsz_aufnahme_permissions SET keyreadable = 'PsychiaterIn (Kontaktdaten)' WHERE keymachine = 'psychiater';
UPDATE opsz_aufnahme_permissions SET keyreadable = 'UnterstützerIn (Kontaktdaten)' WHERE keymachine = 'unterstuetzer';
UPDATE opsz_aufnahme_permissions SET keyreadable = 'RechtsanwältIn (Kontaktdaten)' WHERE keymachine = 'rechtsanwalt';
UPDATE opsz_aufnahme_permissions SET keyreadable = 'SWE (UnterstützerIn)' WHERE keymachine = 'swe_unterstuetzer';
INSERT INTO opsz_termine_permissions (keymachine,keyreadable,realid,typelist,edittype,referencetag) VALUES ('stattgefunden','Termin stattgefunden',4.5,'VARCHAR(30)','LIST','_terminstattgefunden');
INSERT INTO opsz_termine_references (referencetag,allowed_values) VALUES ('_terminstattgefunden','["*ja","Absage KlientIn","Absage PSZ","KlientIn nicht erschienen"]');
ALTER TABLE opsz_termine ADD COLUMN `stattgefunden` VARCHAR(30);
