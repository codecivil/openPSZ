-- BITTE ERST NACH opszdiff1.7.20.script AUSFÜHREN!
-- dolmetschereinsatz anpassen
UPDATE `opsz_dolmetschereinsatz_permissions`SET `keymachine`= 'dolmimwst',`keyreadable`= 'MwSt',`typelist`= 'DECIMAL(6,2)',`edittype`= 'DECIMAL; DERIVED',`defaultvalue`= '(dolmibrutto-dolminetto)' WHERE `keymachine` = 'dolmimwst';
UPDATE `opsz_dolmetschereinsatz_permissions`SET `keymachine`= 'dolmisprache',`keyreadable`= 'Sprache',`typelist`= 'VARCHAR(40)',`edittype`= 'EXTENSIBLE LIST' WHERE `keymachine` = 'dolmisprache';
UPDATE `os_tables`SET `iconname`= 'globe',`tablemachine`= 'opsz_dolmetschereinsatz',`tablereadable`= 'Dolmetschereinsatz',`allowed_roles`= '[0]',`delete_roles`= '[0]',`displayforeign`= '["opsz_termine__dolmetscher","opsz_termine__stattgefunden"]' WHERE `tablemachine` = 'opsz_dolmetschereinsatz';
UPDATE `opsz_dolmetschereinsatz_permissions`SET `keymachine`= 'dolmistatus',`keyreadable`= 'Status',`realid`= '4.000',`typelist`= 'VARCHAR(20)',`edittype`= 'LIST',`referencetag`= '_dolmistatus',`role_0`= '0' WHERE `keymachine`= 'dolmistatus';
INSERT  INTO `opsz_dolmetschereinsatz_references` (`referencetag`,`allowed_values`) VALUES ('_dolmistatus','["*stattgefunden","abgesagt"]');
INSERT  INTO `opsz_dolmetschereinsatz_references` (`referencetag`,`allowed_values`) VALUES ('_dolmibemerkung','["_HIDE_"]');
INSERT  INTO `opsz_dolmetschereinsatz_references` (`referencetag`,`depends_on_key`,`depends_on_value`,`allowed_values`) VALUES ('_dolmibemerkung','dolmistatus','abgesagt','["_SHOW_"]');
-- Funktion createDolmiInvoice registrieren
INSERT  INTO `os_functions` (`iconname`,`functionmachine`,`functionreadable`,`functionscope`,`allowed_roles`,`functiontarget`) SELECT 'receipt','createDolmiInvoice','Dolmetscherrechnung erstellen','DETAILS','[0]','_popup_' FROM DUAL WHERE  (SELECT count(functionmachine) FROM `os_functions` where functionmachine = 'createDolmiInvoice') = 0;
-- dolmetscherrechnung anpassen
UPDATE `opsz_dolmetscherrechnung_permissions`SET `keymachine`= 'dlmrgmwst',`keyreadable`= 'MwSt',`realid`= '11.000',`typelist`= 'DECIMAL(6,2)',`edittype`= 'DECIMAL; DERIVED',`defaultvalue`= '(dlmrgbrutto-dlmrgnetto)',`role_0`= '0' WHERE `keymachine`= 'dlmrgmwst';
UPDATE `opsz_dolmetscherrechnung_permissions`SET `keymachine`= 'dlmrggenerated',`keyreadable`= 'Rechnung erzeugt',`realid`= '3.000',`typelist`= 'VARCHAR(30)',`edittype`= 'LIST',`referencetag`= '_dlmrggenerated' WHERE `keymachine`= 'dlmrggenerated';
INSERT  INTO `opsz_dolmetscherrechnung_references` (`referencetag`,`allowed_values`) VALUES ('_dlmrggenerated','["*nein","ja"]');
-- printResults in scope PORTRAIT registrieren (kann dann von anderen Funktionen in Ausgabe gesetzt werden)
INSERT  INTO `os_functions` (`iconname`,`functionmachine`,`functionreadable`,`functionscope`,`allowed_roles`,`functionconfig`,`functionflags`) SELECT 'print','printResults','Eintrag drucken','PORTRAIT','[0]','{"orientation": "portrait"}','[]' FROM DUAL WHERE  (SELECT count(functionmachine) FROM `os_functions` where functionmachine = 'printResults' and functionscope = 'PORTRAIT') = 0;
