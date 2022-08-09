-- diversify group offers
UPDATE `opsz_aufnahme_references`SET `referencetag`= '_angebote',`allowed_values`= '["*zu klären","OS","Einzelgespräche","Kreativgruppe","Entspannungsgruppe","Stabilisierungsgruppe","geschlechtsspezifische Gruppe","weitere Gruppenangebot bis August 2022","Vermittlung in die Regelversorgung","Vermittlung: Beratungsstelle","Vermittlung: PsychiaterIn","Vermittlung: Psychotherapie","Vermittlung: Rolling clinic","ambulant betreutes Wohnen","Projekt ASU"]' WHERE `referencetag` = '_angebote';
UPDATE `opsz_termine_references`SET `referencetag`= '_termineart',`allowed_values`= '["OS","Einzelgespräch","Vermittlung","Kreativgruppe","Entspannungsgruppe","Stabilisierungsgruppe","geschlechtsspezifische Gruppe","*Sonstiges"]' WHERE `referencetag` = '_termineart';
-- update dependent references so that added items keep visible
UPDATE `opsz_aufnahme_references`SET `referencetag`= '_angebotedetail',`depends_on_key`= 'angebot',`depends_on_value`= 'Entspannungsgruppe',`allowed_values`= '["-"]' WHERE depends_on_key = 'angebot' and depends_on_value = 'Gruppenangebot';
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`depends_on_key`,`depends_on_value`,`allowed_values`) VALUES ('_angebotedetail','angebot','Kreativgruppe','["-"]');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`depends_on_key`,`depends_on_value`,`allowed_values`) VALUES ('_angebotedetail','angebot','Stabilisierungsgruppe','["-"]');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`depends_on_key`,`depends_on_value`,`allowed_values`) VALUES ('_angebotedetail','angebot','geschlechtsspezifische Gruppe','["-"]');
INSERT  INTO `opsz_aufnahme_references` (`referencetag`,`depends_on_key`,`depends_on_value`,`allowed_values`) VALUES ('_angebotedetail','angebot','weitere Gruppenangebot bis August 2022','["-"]');
-- update old value "Gruppenangebot" to new group offer dependent on choice in angebote_detail
UPDATE opsz_aufnahme SET angebot = REPLACE(angebot,'"Gruppenangebot"','"Gruppenangebot","Kreativgruppe"') WHERE angebotedetail LIKE '%Freizeitgruppe%';
UPDATE opsz_aufnahme SET angebot = REPLACE(angebot,'"Gruppenangebot"','"Gruppenangebot","Entspannungsgruppe"') WHERE angebotedetail LIKE '%PMR%';
UPDATE opsz_aufnahme SET angebot = REPLACE(angebot,'"Gruppenangebot"','"Gruppenangebot","geschlechtsspezifische Gruppe"') WHERE angebotedetail LIKE '%Frauengruppe%';
UPDATE opsz_aufnahme SET angebot = REPLACE(angebot,'"Gruppenangebot"','"Gruppenangebot","Gruppenangebot bis August 2022"') WHERE angebotedetail NOT LIKE '%Frauengruppe%' AND angebotedetail NOT LIKE '%PMR%' AND angebotedetail NOT LIKE '%Freizeitgruppe%';
UPDATE opsz_aufnahme SET angebot = REPLACE(angebot,'"Gruppenangebot"','');
UPDATE opsz_aufnahme SET angebot = REPLACE(angebot,',,',',');
UPDATE opsz_aufnahme SET angebot = REPLACE(angebot,'[,','[');
UPDATE opsz_aufnahme SET angebot = REPLACE(angebot,',]',']');
-- now for termine
-- make type entry bigger
UPDATE opsz_termine_permissions SET typelist = 'VARCHAR(50)' where keymachine = 'typ';
ALTER TABLE opsz_termine MODIFY typ VARCHAR(50); 
-- now update values
UPDATE opsz_termine SET typ = "Kreativgruppe" WHERE typ = "Freizeitgruppe";
UPDATE opsz_termine SET typ = "Entspannungsgruppe" WHERE typ = "PMR";
UPDATE opsz_termine SET typ = "geschlechtsspezifische Gruppe" WHERE typ = "Männergruppe" OR typ = "Frauengruppe";
