-- Vermittlungsänderungen II --

-- Aufnahmebogen --
ALTER TABLE `opsz_aufnahme` DROP COLUMN `vermittlungsstand`;
DELETE FROM `opsz_aufnahme_permissions` WHERE keymachine = 'vermittlungsstand';

