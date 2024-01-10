-- openStatAdmin-log started 08.01.2024 16:59:10
UPDATE `opsz_dolmetschereinsatz_permissions`SET `id`= '9',`keymachine`= 'dolmimwst',`keyreadable`= 'MwSt',`typelist`= 'DECIMAL(6,2)',`edittype`= 'DECIMAL; DERIVED',`defaultvalue`= '(dolmibrutto-dolminetto)' WHERE `keymachine` = 'dolmimwst';
UPDATE `opsz_dolmetschereinsatz_permissions`SET `keymachine`= 'dolmisprache',`keyreadable`= 'Sprache',`typelist`= 'VARCHAR(40)',`edittype`= 'EXTENSIBLE LIST' WHERE `keymachine` = 'dolmisprache';
UPDATE `os_tables`SET `iconname`= 'globe',`tablemachine`= 'opsz_dolmetschereinsatz',`tablereadable`= 'Dolmetschereinsatz',`allowed_roles`= '[0]',`delete_roles`= '[0]',`displayforeign`= '["opsz_termine__dolmetscher","opsz_termine__stattgefunden"]' WHERE `tablemachine` = 'opsz_dolmetschereinsatz';
