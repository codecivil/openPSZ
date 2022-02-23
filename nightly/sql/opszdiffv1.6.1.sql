-- need more space for references in opsz_aufnahme
ALTER TABLE opsz_aufnahme_permissions MODIFY COLUMN referencetag VARCHAR(255);
