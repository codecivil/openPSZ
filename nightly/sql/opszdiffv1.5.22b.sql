-- Vermittlungslisten Update
UPDATE `opsz_vermittlungslisten_permissions` SET `keymachine`= 'fahrtkostenantrag',`keyreadable`= 'Fahrtkostenantrag: Verfahrensstand + zuständige Behörde + ges. Grundlage + Zweck + gestellt am + Antwort am + Entscheidung + Widerspruch + Bewilligungsbeginn + Bewilligungsende + Folgeantrag zu stellen bis',`realid`= '15.000',`typelist`= 'TEXT',`edittype`= 'LIST + LIST + TEXT + TEXT + DATE + DATE + LIST + LIST + DATE + DATE + DATE; MULTIPLE',`referencetag`= '_verfahrensstand + _behoerde + _none_ + _none_ + _none_ + _none_ + _entscheidung + _widerspruch_fahrtkosten' WHERE `keymachine`= 'fahrtkostenantrag';
UPDATE `opsz_vermittlungslisten_permissions`SET `keymachine`= 'therapieantrag',`keyreadable`= 'Therapieantrag: Verfahrensstand + zuständige Behörde + ges. Grundlage + gestellt am + Antwort am + Entscheidung + Widerspruch + Bewilligungsbeginn + Bewilligungsende + Folgeantrag zu stellen bis',`realid`= '13.000',`typelist`= 'TEXT',`edittype`= 'LIST + LIST + TEXT + DATE + DATE + LIST + LIST + DATE + DATE + DATE; MULTIPLE',`referencetag`= '_verfahrensstand + _behoerde + _none_ + _none_ + _none_ + _entscheidung + _widerspruch_therapie' WHERE `keymachine`= 'therapieantrag';
UPDATE `opsz_vermittlungslisten_permissions`SET `keymachine`= 'dolmetscherinnenantrag',`keyreadable`= 'DolmetscherInnenantrag: Verfahrensstand + zuständige Behörde + ges. Grundlage + gestellt am + Antwort am + Entscheidung + Widerspruch + Bewilligungsbeginn + Bewilligungsende + Folgeantrag zu stellen bis',`realid`= '14.000',`typelist`= 'TEXT',`edittype`= 'LIST + LIST + TEXT + DATE + DATE + LIST + LIST + DATE + DATE + DATE; MULTIPLE',`referencetag`= '_verfahrensstand + _behoerde + _none_ + _none_ + _none_ + _entscheidung + _widerspruch_dolmetscherinnen' WHERE `keymachine`= 'dolmetscherinnenantrag';
DELETE FROM `opsz_vermittlungslisten_references` WHERE `referencetag`= '_widerspruch_fahrtkosten';
DELETE FROM `opsz_vermittlungslisten_references` WHERE `referencetag`= '_widerspruch_dolmetscherinnen';
DELETE FROM `opsz_vermittlungslisten_references` WHERE `referencetag`= '_widerspruch_therapie';
INSERT INTO `opsz_vermittlungslisten_references` (`referencetag`,`depends_on_key`,`depends_on_value`,`allowed_values`) VALUES ('_widerspruch_fahrtkosten','fahrtkostenantrag[6];local','Ablehnung','[\"nein\",\"ja\"]'),('_widerspruch_fahrtkosten','fahrtkostenantrag[6];local','Teilweise angenommen','[\"nein\",\"ja\"]'),('_widerspruch_fahrtkosten',NULL,NULL,'[\"*nicht anwendbar\"]'),('_widerspruch_dolmetscherinnen',NULL,NULL,'[\"*nicht anwendbar\"]'),('_widerspruch_therapie',NULL,NULL,'[\"*nicht anwendbar\"]'),('_widerspruch_dolmetscherinnen','dolmetscherinnenantrag[5];local','Ablehnung','[\"nein\",\"ja\"]'),('_widerspruch_dolmetscherinnen','dolmetscherinnenantrag[5];local','Teilweise angenommen','[\"nein\",\"ja\"]'),('_widerspruch_therapie','therapieantrag[5];local','Ablehnung','[\"nein\",\"ja\"]'),('_widerspruch_therapie','therapieantrag[5];local','Teilweise angenommen','[\"nein\",\"ja\"]');
UPDATE `opsz_vermittlungslisten_references` SET `allowed_values` = '["*nein","ja"]' WHERE `referencetag` = '_yesno';