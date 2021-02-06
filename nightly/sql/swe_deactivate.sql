-- BETTER EXECUTE swe_2swes.sql BEFORE (for users' convenience)
-- deactivates old swe_ fields
-- EXECUTE swe_2swes.sql BEFORE REMOVAL OF old swe_ fields (at least a day later!)
UPDATE opsz_aufnahme_permissions SET edittype="NONE" WHERE keymachine LIKE '%swe\_%';
