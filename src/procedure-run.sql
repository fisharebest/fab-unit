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
	COMMENT 'Run the unit tests for a specied database and test-prefix'
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

	DELETE FROM result;
	SET @_fab_expect_to_fail := FALSE;

	CALL assert_no_reserved_words(p_schema);
	CALL assert_table_comments   (p_schema);
	CALL assert_column_comments  (p_schema, NULL);

	OPEN c_test_case;
	BEGIN
		DECLARE EXIT HANDLER FOR NOT FOUND CLOSE c_test_case;
		LOOP
			FETCH c_test_case INTO l_routine_name, l_routine_comment;
			SET @_fab_routine_comment := l_routine_comment;
			CALL execute_immediate(CONCAT('CALL ', p_schema, '.', l_routine_name));
		END LOOP;
	END;

	SELECT
		script,
		CASE WHEN MIN(result)
			THEN 'pass'
			ELSE 'fail'
		END AS result,
		CASE WHEN MIN(result)
			THEN CONCAT(COUNT(result), CASE WHEN COUNT(result)=1 THEN ' test' ELSE ' tests' END)
			ELSE GROUP_CONCAT(CASE WHEN result THEN NULL ELSE test END SEPARATOR '\n')
		END AS details
	FROM result
	GROUP BY script;

END //

