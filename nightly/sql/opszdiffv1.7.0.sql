-- There was never an official edittype change of angebotedetail, so better do it now
UPDATE `opsz_aufnahme_permissions` SET `typelist`= 'TEXT',`edittype`= 'EXTENSIBLE LIST; MULTIPLE',`referencetag`= '_angebotedetail' WHERE `keymachine`= 'angebotedetail';
