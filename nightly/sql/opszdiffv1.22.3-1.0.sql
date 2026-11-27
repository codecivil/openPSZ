-- add trans to geschlecht
UPDATE `opsz_aufnahme_references`SET `allowed_values`= '["*zu klären","männlich","weiblich","divers","trans*"]' WHERE `referencetag`= '_geschlecht';
