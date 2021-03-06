---
--- DO NOT IMPORT THIS USING openStatAdmin! DO IT BY COMMAND LINE LIKE mysql -u root -p opsz < swe_s2swes.sql ! openStatAdmin DOES NOT SUPPORT PROCEDURES!
---
DROP PROCEDURE IF EXISTS _convert;

DELIMITER //
CREATE PROCEDURE _convert()
BEGIN
	DECLARE num_rows,i INT;
	DECLARE col_name VARCHAR(255);
	DECLARE col_names CURSOR FOR
	  SELECT DISTINCT column_name
	  FROM INFORMATION_SCHEMA.COLUMNS
	  WHERE table_name = 'opsz_aufnahme' AND column_name LIKE '%swe\_%'
	  ORDER BY column_name;
	OPEN col_names;  
	select FOUND_ROWS() into num_rows;

	CREATE TEMPORARY TABLE swetranslate (colname VARCHAR(40), _swe VARCHAR(60));
	INSERT INTO swetranslate VALUES ('swe_hausarzt','Hausarzt / Hausärztin'),('swe_psychiater','Psychiater*in / Neurolog*in'),('swe_unterstuetzer','Unterstützer*in'),('swe_rechtsanwalt','Rechtsanwalt / Rechtsanwältin'),('swe_krankenversicherung','Krankenkasse'),('swe_familienhilfe','Familienhilfe'),('swe_beratungsstellen','Beratungsstellen'),('swe_psychotherapeut','Psycholog*innen/Psychotherapeut*innen');

	UPDATE opsz_aufnahme SET schweigen = '[]';
	
	SET i = 1;
	the_loop: LOOP

	   IF i > num_rows THEN
			CLOSE col_names;
			LEAVE the_loop;
		END IF;


		FETCH col_names 
		INTO col_name;
		SELECT _swe FROM swetranslate WHERE colname = col_name INTO @_swe;
/*this works, too, but may be less efficient:
		SET @stmt := CONCAT('UPDATE opsz_aufnahme set schweigen =  JSON_MERGE_PRESERVE(CONCAT(\'[\"',@_swe,'\"]\'),schweigen) WHERE ',col_name,' = \"ja\"');
*/
		SET @stmt := CONCAT('UPDATE opsz_aufnahme set schweigen =  JSON_ARRAY_APPEND(schweigen,\'\$\',@_swe) WHERE ',col_name,' = \"ja\"');
		PREPARE stmt from @stmt;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
		SET i = i + 1;  
	END LOOP the_loop;
	DROP TABLE swetranslate;
	/* empty values make problems in edit.php, so: */
	UPDATE opsz_aufnahme SET schweigen = '[""]' WHERE schweigen = '[]';
END; //

DELIMITER ;
CALL _convert;
DROP PROCEDURE _convert;
