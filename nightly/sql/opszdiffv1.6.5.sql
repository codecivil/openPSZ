-- ersetze missbr. Konsum durch schädlicher Gebrauch und entferne die Option
UPDATE opsz_aufnahme set anzeichen =  REPLACE(anzeichen,'missbräuchlicher Konsum','schädlicher Gebrauch');
UPDATE opsz_aufnahme_references SET allowed_values='["*zu klären","Aufklärungs- oder Präventionsbedarf","schädlicher Gebrauch","Abhängigkeit/en","riskanter Konsum","_keine"]' WHERE referencetag = '_anzeichen';
-- Frühdiagnostik-Oerbke zu Frühdiagnostik
UPDATE opsz_aufnahme_permissions SET keyreadable = 'Frühdiagnostik' WHERE keymachine='fruehdiagnostik';
