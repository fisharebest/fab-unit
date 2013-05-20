DROP PROCEDURE IF EXISTS reserved_words //

CREATE PROCEDURE reserved_words (
	IN p_database VARCHAR(255)
)
	COMMENT 'Check if any schema objects are named after reserved words'
	LANGUAGE SQL
	DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	SELECT p_database;
END //
