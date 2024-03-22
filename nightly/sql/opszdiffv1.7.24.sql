-- mache Fallverantwortliche zu Chronik
UPDATE `opsz_aufnahme_permissions`SET `keyreadable`= 'Fallverantwortliche(r): Name + seit',`typelist`= 'TEXT',`edittype`= 'EXTENSIBLE LIST + DATE' WHERE `keymachine`= 'verantwortlich';
-- konvertiere alte Einträge
UPDATE opsz_aufnahme SET verantwortlich = CONCAT('[["',verantwortlich,'"],[""]]') WHERE NOT verantwortlich LIKE '[%]';
