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

DROP PROCEDURE IF EXISTS run //

CREATE PROCEDURE run (
	p_schema TEXT,
	p_prefix TEXT
)
	COMMENT 'Run the unit tests for current database'
	LANGUAGE SQL
	DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	DECLARE l_routine_name    TEXT;
	DECLARE l_routine_comment TEXT;
	
	DECLARE c_test_case CURSOR FOR
	SELECT routine_name, routine_comment
	FROM   information_schema.routines
	WHERE  routine_schema = p_schema
	AND    routine_type   = 'PROCEDURE'
	AND    routine_name   LIKE CONCAT(COALESCE(p_prefix, 'test_'), '%')
	AND    routine_name   NOT LIKE '%_set_up'
	AND    routine_name   NOT LIKE '%_tear_down';

	CALL fab_unit.assert_no_reserved_words(p_schema);
	CALL fab_unit.assert_table_comments   (p_schema);
	CALL fab_unit.assert_column_comments  (p_schema, NULL);

	OPEN c_test_case;
	BEGIN
		DECLARE EXIT HANDLER FOR NOT FOUND CLOSE c_test_case;
		LOOP
			FETCH c_test_case INTO l_routine_name, l_routine_comment;
			SELECT l_routine_name, l_routine_comment;
		END LOOP;
	END;

END //

