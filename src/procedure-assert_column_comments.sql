-- fab-unit - A unit test framework for MySQL applications
--
-- Copyright (c) 2013 Greg Roach, fisharebest@gmail.com
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

DROP PROCEDURE IF EXISTS assert_column_comments //

CREATE PROCEDURE assert_column_comments(
	IN p_schema  TEXT,
	IN p_table   TEXT
)
	COMMENT 'Check that all columns in a table have comments'
	LANGUAGE SQL
	DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	DECLARE l_column TEXT;

	DECLARE c_column CURSOR FOR
	SELECT column_name
	FROM   information_schema.columns
	JOIN   information_schema.tables USING (table_schema, table_name)
	WHERE  table_schema = p_schema
	AND    table_type = 'BASE TABLE'
	AND    table_name = p_table
	AND    column_comment = '';

	OPEN c_column;
	BEGIN
		DECLARE EXIT HANDLER FOR NOT FOUND CLOSE c_column;
		LOOP
			FETCH c_column INTO l_column;
			CALL assert(FALSE, CONCAT('assert_column_comments(', p_table, '.', l_column, ')'));
		END LOOP;
	END;

	IF l_column IS NULL THEN
		CALL assert(TRUE, CONCAT('assert_column_comments(', p_table, ')'));
	END IF;
END //

