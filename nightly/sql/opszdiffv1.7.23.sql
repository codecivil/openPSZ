-- repariere falsch formatierte Notizen
UPDATE opsz_aufnahme SET notiz = NULL WHERE JSON_LENGTH(notiz) = 1;

-- aktualisiere SWEs
UPDATE `opsz_aufnahme_references` SET `allowed_values`= '["","Hausarzt / Hausärztin","Psychiater*in / Neurolog*in","Psycholog*innen/Psychotherapeut*innen","Kliniken","Unterstützer*in","Mitarbeiter*innen der Flüchtlingsunterkunft","Angehörig*e","Rechtsanwalt / Rechtsanwältin","Ausländerbehörde","Sozialamt / Agentur für Arbeit / jobcenter","Krankenkasse","Beratungsstellen","Familienhilfe","gesetzliche*r Betreuer*in / Vormund","Bundesamt","*SWE liegt nicht vor","Schule und Lehrkräfte"]' WHERE `referencetag`= '_swes';
