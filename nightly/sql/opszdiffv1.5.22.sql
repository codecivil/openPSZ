-- drop swe_ columns (replaced by combi field swes)
ALTER TABLE opsz_aufnahme DROP COLUMN swe_beratungsstellen;
ALTER TABLE opsz_aufnahme DROP COLUMN swe_familienhilfe;
ALTER TABLE opsz_aufnahme DROP COLUMN swe_hausarzt;
ALTER TABLE opsz_aufnahme DROP COLUMN swe_krankenversicherung;
ALTER TABLE opsz_aufnahme DROP COLUMN swe_psychiater;
ALTER TABLE opsz_aufnahme DROP COLUMN swe_psychotherapeut;
ALTER TABLE opsz_aufnahme DROP COLUMN swe_rechtsanwalt;
ALTER TABLE opsz_aufnahme DROP COLUMN swe_unterstuetzer;
DELETE FROM `opsz_aufnahme_permissions` WHERE keymachine LIKE 'swe\_%';

--Vermittlungslisten Update
UPDATE os_tables SET displayforeign = '["opsz_aufnahme__verantwortlich","opsz_aufnahme__name","opsz_aufnahme__vorname","opsz_aufnahme__adresse","opsz_aufnahme__sprachkenntnisse","opsz_aufnahme__genderaspekte","opsz_aufnahme__gesundheitsversorgung","opsz_aufnahme__lebensunterhalt","opsz_aufnahme__swes"]' WHERE tablemachine = 'opsz_vermittlungslisten';
UPDATE opsz_vermittlungslisten_permissions SET edittype = 'DATE + LIST + TEXT + FREE + DATETIME; MULTIPLE' WHERE keymachine = 'vermitteltzu';
UPDATE `opsz_vermittlungslisten_permissions`SET `keymachine`= 'angefragtbei',`keyreadable`= 'angefragte TherapeutInnen / ÄrztInnen: Datum + Name, Vorname + Ort + Ergebnis + Warteliste + ggf. Nachfragen ab',`realid`= '12.000',`typelist`= 'TEXT',`edittype`= 'DATE + TEXT + FREE + FREE + LIST + DATE; MULTIPLE',`referencetag`= '_none_ + _none_ + _none_ + _none_ + _yesno + _none_' WHERE `keymachine`= 'angefragtbei';
INSERT  INTO `opsz_vermittlungslisten_references` (`referencetag`,`allowed_values`) VALUES ('_yesno','["*nein",''ja"]');
UPDATE `opsz_vermittlungslisten_permissions`SET `keymachine`= 'therapieantrag',`keyreadable`= 'Therapieantrag: Verfahrensstand + zuständige Behörde + ges. Grundlage + gestellt am + Antwort am + Entscheidung + Widerspruch + Bewilligungsbeginn + Bewilligungsende + Folgeantrag zu stellen bis',`realid`= '13.000',`typelist`= 'TEXT',`edittype`= 'LIST + LIST + TEXT + DATE + DATE + LIST + LIST + DATE + DATE + DATE; MULTIPLE',`referencetag`= '_verfahrensstand + _behoerde + _none_ + _none_ + _none_ + _entscheidung + _widerspruch' WHERE `keymachine`= 'therapieantrag';
UPDATE `opsz_vermittlungslisten_permissions`SET `keymachine`= 'dolmetscherinnenantrag',`keyreadable`= 'DolmetscherInnenantrag: Verfahrensstand + zuständige Behörde + ges. Grundlage + gestellt am + Antwort am + Entscheidung + Widerspruch + Bewilligungsbeginn + Bewilligungsende + Folgeantrag zu stellen bis',`realid`= '14.000',`typelist`= 'TEXT',`edittype`= 'LIST + LIST + TEXT + DATE + DATE + LIST + LIST + DATE + DATE + DATE; MULTIPLE',`referencetag`= '_verfahrensstand + _behoerde + _none_ + _none_ + _none_ + _entscheidung + _widerspruch' WHERE `keymachine`= 'dolmetscherinnenantrag';
UPDATE `opsz_vermittlungslisten_permissions`SET `keymachine`= 'fahrtkostenantrag',`keyreadable`= 'Fahrtkostenantrag: Verfahrensstand + zuständige Behörde + ges. Grundlage + gestellt am + Antwort am + Entscheidung + Widerspruch + Bewilligungsbeginn + Bewilligungsende + Folgeantrag zu stellen bis',`realid`= '15.000',`typelist`= 'TEXT',`edittype`= 'LIST + LIST + TEXT + DATE + DATE + LIST + LIST + DATE + DATE + DATE; MULTIPLE',`referencetag`= '_verfahrensstand + _behoerde + _none_ + _none_ + _none_ + _entscheidung + _widerspruch_fahrtkosten' WHERE `keymachine`= 'fahrtkostenantrag';
UPDATE `opsz_vermittlungslisten_references`SET `referencetag`= '_widerspruch_fahrtkosten',`depends_on_key`= 'fahrtkostenantrag[6];local',`depends_on_value`= 'Ablehnung',`allowed_values`= '["nein","ja"]' WHERE `referencetag`= '_widerspruch_fahrtkosten';
UPDATE `opsz_vermittlungslisten_references`SET `referencetag`= '_widerspruch_dolmetscherinnen',`depends_on_key`= 'dolmetscherinnenantrag[5];local',`depends_on_value`= 'Ablehnung',`allowed_values`= '["nein","ja"]' WHERE `referencetag`= '_widerspruch_dolmetscherinnen';
UPDATE `opsz_vermittlungslisten_references`SET `referencetag`= '_widerspruch_therapie',`depends_on_key`= 'therapieantrag[5];local',`depends_on_value`= 'Ablehnung',`allowed_values`= '["nein","ja"]' WHERE `referencetag`= '_widerspruch_therapie';
