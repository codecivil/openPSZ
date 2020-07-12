-- delete old columns
ALTER TABLE opsz_aufnahme DROP COLUMN  `diagnose`;
DELETE FROM opsz_aufnahme_permissions WHERE keymachine = 'diagnose';
ALTER TABLE opsz_aufnahme DROP COLUMN  `diagnosedetail`;
DELETE FROM opsz_aufnahme_permissions WHERE keymachine = 'diagnosedetail';

-- create new compound fields
ALTER TABLE opsz_aufnahme ADD COLUMN `genderaspekte` TEXT;
INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype,referencetag) SELECT 'genderaspekte','Genderaspekte: Gruppe + Geschlecht',26.0,'TEXT','LIST + LIST; MULTIPLE','_gendergruppe + _genderwahl' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'genderaspekte') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_permissions` where keymachine = 'genderaspekte') = 0;
INSERT INTO opsz_aufnahme_references (referencetag,allowed_values) SELECT '_gendergruppe','["","PsychiaterIn","PsychotherapeutIn","DolmetscherIn"]' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'genderaspekte') > 0 AND (SELECT count(id) FROM `opsz_aufnahme_references` where referencetag = '_gendergruppe') = 0;
INSERT INTO opsz_aufnahme_references (referencetag,allowed_values) SELECT '_genderwahl','["Frau","Mann","*egal"]' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'genderaspekte') > 0 AND (SELECT count(id) FROM `opsz_aufnahme_references` where referencetag = '_genderwahl') = 0;

ALTER TABLE opsz_aufnahme ADD COLUMN `sprachkenntnisse` TEXT;
INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype) SELECT 'sprachkenntnisse','Sprachkenntnisse: Sprache + Kommentar',8.0,'TEXT','EXTENSIBLE LIST + TEXT; MULTIPLE' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'sprachkenntnisse') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_permissions` where keymachine = 'sprachkenntnisse') = 0;

ALTER TABLE opsz_aufnahme ADD COLUMN `krankenhausaufenthaltdetails` TEXT;
INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype) SELECT 'krankenhausaufenthaltdetails','Krankenhausaufenthalte: Krankenhaus + von + bis',24.2,'TEXT','TEXT + DATE + DATE; MULTIPLE' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'krankenhausaufenthaltdetails') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_permissions` where keymachine = 'krankenhausaufenthaltdetails') = 0;

ALTER TABLE opsz_aufnahme ADD COLUMN `diagnoseexternkombi` TEXT;
INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype,referencetag) SELECT 'diagnoseexternkombi','externe psychiatrische Diagnosen: Diagnose + ',26.0,'TEXT','LIST + LIST; MULTIPLE','_diagnoseextern + _diagnosegesichert' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'diagnoseexternkombi') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_permissions` where keymachine = 'diagnoseexternkombi') = 0;
INSERT INTO opsz_aufnahme_references (referencetag,allowed_values) SELECT '_diagnosegesichert','["","Gesicherte Diagnose","Verdachtsdiagnose"]' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'diagnoseexternkombi') > 0 AND (SELECT count(id) FROM `opsz_aufnahme_references` where referencetag = '_diagnosegesichert') = 0;

-- copy data and delete old fields
UPDATE opsz_aufnahme SET genderaspekte = CONCAT('["PsychotherapeutIn","',`geschlechttherapeutwichtig`,'"]');
ALTER TABLE opsz_aufnahme DROP COLUMN `geschlechttherapeutwichtig`;
DELETE FROM opsz_aufnahme_permissions WHERE keymachine = 'geschlechttherapeutwichtig';

UPDATE opsz_aufnahme SET sprachedetail = '' WHERE sprachedetail IS NULL;
UPDATE opsz_aufnahme SET sprachkenntnisse = CONCAT('[',`sprache`,',["',`sprachedetail`,'"]]');
ALTER TABLE opsz_aufnahme DROP COLUMN `sprache`;
ALTER TABLE opsz_aufnahme DROP COLUMN `sprachedetail`;
DELETE FROM opsz_aufnahme_permissions WHERE keymachine = 'sprache';
DELETE FROM opsz_aufnahme_permissions WHERE keymachine = 'sprachedetail';

UPDATE opsz_aufnahme SET diagnoseexternkombi = CONCAT('[',`diagnoseextern`,',[""]]');
ALTER TABLE opsz_aufnahme DROP COLUMN `diagnoseextern`;
DELETE FROM opsz_aufnahme_permissions WHERE keymachine = 'diagnoseextern';

-- some corrections
UPDATE opsz_aufnahme_references SET allowed_values='["*zu klären","OS","Einzelgespräche","Gruppenangebot","Vermittlung in die Regelversorgung","Vermittlung: Beratungsstelle","Vermittlung: PsychiaterIn","Vermittlung: Psychotherapie","Vermittlung: Rolling clinic","ambulant betreutes Wohnen","Projekt ASU"]' WHERE referencetag = '_angebote';
