-- new grants for secrets
GRANT SELECT ON os_secrets TO OPSZ_LOGIN;
GRANT SELECT (secretname) ON os_passwords to OPSZ_LOGIN;
FLUSH PRIVILEGES;

-- fix for suizidale_absichten
UPDATE opsz_aufnahme_references SET depends_on_key='suizidale_absichten[0];local' WHERE depends_on_key='suididale_absichten';
