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

DELIMITER //

SET SESSION
	autocommit               := TRUE,
	character_set_client     := utf8mb4,
	character_set_results    := utf8mb4,
	character_set_connection := utf8mb4,
	collation_connection     := utf8mb4_general_ci,
	foreign_key_checks       := TRUE,
	innodb_strict_mode       := ON,
	sql_mode                 := 'TRADITIONAL,NO_AUTO_VALUE_ON_ZERO',
	sql_notes                := TRUE,
	sql_warnings             := TRUE,
	unique_checks            := TRUE //

DROP DATABASE IF EXISTS fab_unit;
CREATE DATABASE fab_unit COLLATE utf8mb4_general_ci //

USE fab_unit //

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

DROP PROCEDURE IF EXISTS assert_equals //

CREATE PROCEDURE assert_equals (
	IN p_expression1 BLOB,
	IN p_expression2 BLOB,
	IN p_message     TEXT
)
	COMMENT 'Assert that two values are equal'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	SET p_message := COALESCE(p_message, 'assert_equals()');
	CALL assert(p_expression1 <=> p_expression2, p_message);
END //

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

DROP PROCEDURE IF EXISTS assert_false //

CREATE PROCEDURE assert_false (
	IN p_expression BOOLEAN,
	IN p_message    TEXT
)
	COMMENT 'Assert that a value equates to FALSE'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	SET p_message := COALESCE(p_message, 'assert_false()');
	CALL assert(p_expression = FALSE, p_message);
END //

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

DROP PROCEDURE IF EXISTS assert_like_escape //

CREATE PROCEDURE assert_like_escape (
	IN p_expression1 BLOB,
	IN p_expression2 BLOB,
	IN p_escape      CHAR(1),
	IN p_message     TEXT
)
	COMMENT 'Assert that one expression is like another'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	SET p_message := COALESCE(p_message, 'assert_like_escape()');
	CALL assert(p_expression1 LIKE p_expression2 ESCAPE p_escape, p_message);
END //

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

DROP PROCEDURE IF EXISTS assert_like //

CREATE PROCEDURE assert_like (
	IN p_expression1 BLOB,
	IN p_expression2 BLOB,
	IN p_message     TEXT
)
	COMMENT 'Assert that one expression is like another'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	SET p_message := COALESCE(p_message, 'assert_like()');
	CALL assert(p_expression1 LIKE p_expression2, p_message);
END //

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

DROP PROCEDURE IF EXISTS assert_no_reserved_words //

CREATE PROCEDURE assert_no_reserved_words(
	IN p_schema TEXT
)
	COMMENT 'Check if any schema objects are named after reserved words'
	LANGUAGE SQL
	DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	DECLARE l_message TEXT;

	DECLARE c_reserved_word CURSOR FOR
	SELECT CONCAT('Schema `', schema_name, '` is a reserved word')
		FROM information_schema.schemata
		JOIN fab_unit.reserved_word ON (schema_name = reserved_word)
		WHERE schema_name = p_schema
	UNION
	SELECT CONCAT('Table `', table_schema, '`.`', table_name, '` is a reserved word')
		FROM information_schema.tables
		JOIN fab_unit.reserved_word ON (table_name = reserved_word)
		WHERE table_schema = p_schema
	UNION
	SELECT CONCAT('Column `', table_schema, '`.`', table_name, '`.`', column_name, '` is a reserved word')
		FROM information_schema.columns
		JOIN fab_unit.reserved_word ON (column_name = reserved_word)
		WHERE table_schema = p_schema;

	OPEN c_reserved_word;
	BEGIN
		DECLARE EXIT HANDLER FOR NOT FOUND CLOSE c_reserved_word;
		LOOP
			FETCH c_reserved_word INTO l_message;
			CALL assert(FALSE, l_message);
		END LOOP;
	END;
END //

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

DROP PROCEDURE IF EXISTS assert_not_equals //

CREATE PROCEDURE assert_not_equals (
	IN p_expression1 BLOB,
	IN p_expression2 BLOB,
	IN p_message     TEXT
)
	COMMENT 'Assert that two values are not equal'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	SET p_message := COALESCE(p_message, 'assert_not_equals()');
	CALL assert(NOT p_expression1 <=> p_expression2, p_message);
END //

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

DROP PROCEDURE IF EXISTS assert_not_like_escape //

CREATE PROCEDURE assert_not_like_escape (
	IN p_expression1 BLOB,
	IN p_expression2 BLOB,
	IN p_escape      CHAR(1),
	IN p_message     TEXT
)
	COMMENT 'Assert that one expression is not like another'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	SET p_message := COALESCE(p_message, 'assert_not_like_escape()');
	CALL assert(p_expression1 NOT LIKE p_expression2 ESCAPE p_escape, p_message);
END //

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

DROP PROCEDURE IF EXISTS assert_not_like //

CREATE PROCEDURE assert_not_like (
	IN p_expression1 BLOB,
	IN p_expression2 BLOB,
	IN p_message     TEXT
)
	COMMENT 'Assert that one expression is not like another'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	SET p_message := COALESCE(p_message, 'assert_not_like()');
	CALL assert(p_expression1 NOT LIKE p_expression2, p_message);
END //

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

DROP PROCEDURE IF EXISTS assert_not_null //

CREATE PROCEDURE assert_not_null (
	IN p_expression BOOLEAN,
	IN p_message    TEXT
)
	COMMENT 'Assert that a value does not equate to NULL'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	SET p_message := COALESCE(p_message, 'assert_not_null()');
	CALL assert(p_expression IS NOT NULL, p_message);
END //

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

DROP PROCEDURE IF EXISTS assert_not_regexp //

CREATE PROCEDURE assert_not_regexp (
	IN p_expression1 BLOB,
	IN p_expression2 BLOB,
	IN p_message     TEXT
)
	COMMENT 'Assert that an expression does not match a case-insensitive regular expression'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	SET p_message := COALESCE(p_message, 'assert_not_regexp()');
	CALL assert(p_expression1 NOT REGEXP p_expression2, p_message);
END //

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

DROP PROCEDURE IF EXISTS assert_null //

CREATE PROCEDURE assert_null (
	IN p_expression BOOLEAN,
	IN p_message    TEXT
)
	COMMENT 'Assert that a value equates to NULL'
	LANGUAGE SQL
	
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	SET p_message := COALESCE(p_message, 'assert_null()');
	CALL assert(p_expression IS NULL, p_message);
END //

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

DROP PROCEDURE IF EXISTS assert_regexp //

CREATE PROCEDURE assert_regexp (
	IN p_expression1 BLOB,
	IN p_expression2 BLOB,
	IN p_message     TEXT
)
	COMMENT 'Assert that an expression matches a case-insensitive regular expression'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	SET p_message := COALESCE(p_message, 'assert_regexp()');
	CALL assert(p_expression1 REGEXP p_expression2, p_message);
END //

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

DROP PROCEDURE IF EXISTS assert_routine_comments //

CREATE PROCEDURE assert_routine_comments(
	IN p_schema TEXT
)
	COMMENT 'Check that procedures and functions have comments'
	LANGUAGE SQL
	DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	DECLARE l_routine TEXT;

	DECLARE c_routine CURSOR FOR
	SELECT routine_name
	FROM   information_schema.routines
	WHERE  routine_schema = p_schema
	AND    routine_comment = '';

	OPEN c_routine;
	BEGIN
		DECLARE EXIT HANDLER FOR NOT FOUND CLOSE c_routine;
		LOOP
			FETCH c_routine INTO l_routine;
			CALL assert(FALSE, CONCAT('assert_routine_comments(', l_routine, ')'));
		END LOOP;
	END;

	IF l_routine IS NULL THEN
		CALL assert(TRUE, CONCAT('assert_routine_comments()'));
	END IF;
END //

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

DROP PROCEDURE IF EXISTS assert //

CREATE PROCEDURE assert (
	IN p_expression BOOLEAN,
	IN p_message    TEXT
)
	COMMENT 'Log the result of an assertion'
	LANGUAGE SQL
	NOT DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	IF @_fab_expect_to_fail THEN
		SET p_expression := NOT p_expression;
		SET p_message    := CONCAT('NOT ', p_message);
	END IF;
	IF p_expression THEN
		CALL pass(p_message);
	ELSE
		CALL fail(p_message);
	END IF;
	SET @_fab_expect_to_fail := FALSE;
END //

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

DROP PROCEDURE IF EXISTS assert_table_comments //

CREATE PROCEDURE assert_table_comments(
	IN p_schema  TEXT,
	IN p_table   TEXT
)
	COMMENT 'Check that tables have comments'
	LANGUAGE SQL
	DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	DECLARE l_table TEXT;

	DECLARE c_table CURSOR FOR
	SELECT table_name
	FROM   information_schema.tables
	WHERE  table_schema = p_schema
	AND    table_type = 'BASE TABLE'
	AND    table_name = p_table
	AND    table_comment = '';

	OPEN c_table;
	BEGIN
		DECLARE EXIT HANDLER FOR NOT FOUND CLOSE c_table;
		LOOP
			FETCH c_table INTO l_table;
			CALL assert(FALSE, CONCAT('assert_table_comments(', p_table, '.', l_table, ')'));
		END LOOP;
	END;

	IF l_table IS NULL THEN
		CALL assert(TRUE, CONCAT('assert_table_comments(', p_table, ')'));
	END IF;
END //

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

DROP PROCEDURE IF EXISTS assert_true //

CREATE PROCEDURE assert_true (
	IN p_expression BOOLEAN,
	IN p_message    TEXT
)
	COMMENT 'Assert that a value equates to TRUE'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	SET p_message := COALESCE(p_message, 'assert_true()');
	CALL assert(p_expression = TRUE, p_message);
END //

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

DROP PROCEDURE IF EXISTS execute_immediate //

CREATE PROCEDURE execute_immediate (
	IN p_sql TEXT
)
	COMMENT 'Execute dynamic SQL'
	LANGUAGE SQL
	NOT DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	SET @_fab_sql := p_sql;
	PREPARE statement FROM @_fab_sql;
	SET @sql := NULL;
	EXECUTE statement;
	DEALLOCATE PREPARE statement;
END //

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
--
-- Reverse the pass/fail status of the next assertion.
-- This allows us to self-test both pass and fail conditions.

DROP PROCEDURE IF EXISTS expect_to_fail //

CREATE PROCEDURE expect_to_fail()
	COMMENT 'Expect the next test to fail, rather than pass'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	SET @_fab_expect_to_fail := TRUE;
END //

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

DROP PROCEDURE IF EXISTS fail //

CREATE PROCEDURE fail (
	IN p_message  TEXT
)
	COMMENT 'Log the result of a failed assertion'
	LANGUAGE SQL
	NOT DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	INSERT INTO result (script, test, result) VALUES (@_fab_routine_comment, p_message, FALSE)
	ON DUPLICATE KEY UPDATE result = FALSE;
END //

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

DROP PROCEDURE IF EXISTS pass //

CREATE PROCEDURE pass (
	IN p_message  TEXT
)
	COMMENT 'Log the result of a successful assertion'
	LANGUAGE SQL
	NOT DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	INSERT IGNORE INTO result (script, test, result) VALUES (@_fab_routine_comment, p_message, TRUE);
END //

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
	IN p_schema TEXT,
	IN p_prefix TEXT
)
	COMMENT 'Run the unit tests for a specied database and test-prefix'
	LANGUAGE SQL
	DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	DECLARE l_start_time        TIMESTAMP DEFAULT NOW();
	DECLARE l_routine_name      TEXT;
	DECLARE l_routine_comment   TEXT;

	DECLARE c_test_case CURSOR FOR
	SELECT routine_name, routine_comment
	FROM   information_schema.routines
	WHERE  routine_schema = p_schema
	AND    routine_type   = 'PROCEDURE'
	AND    routine_name   LIKE CONCAT(COALESCE(p_prefix, 'test_'), '%')
	AND    routine_name   NOT LIKE '%_set_up'
	AND    routine_name   NOT LIKE '%_tear_down';

	DECLARE c_set_up CURSOR FOR
	SELECT routine_name
	FROM   information_schema.routines
	WHERE  routine_schema = p_schema
	AND    routine_type = 'PROCEDURE'
	AND    routine_name LIKE '%_set_up'
	AND    LOCATE(LEFT(routine_name, LENGTH(routine_name) - 7), l_routine_name) = 1
	ORDER BY LENGTH(routine_name);

	DECLARE c_tear_down CURSOR FOR
	SELECT routine_name
	FROM   information_schema.routines
	WHERE  routine_schema = p_schema
	AND    routine_type = 'PROCEDURE'
	AND    routine_name LIKE '%_tear_down'
	AND    LOCATE(LEFT(routine_name, LENGTH(routine_name) - 10), l_routine_name) = 1
	ORDER BY LENGTH(routine_name) DESC;

	DELETE FROM result;
	SET @_fab_expect_to_fail           := FALSE;

	OPEN c_test_case;
	BEGIN
		DECLARE EXIT HANDLER FOR NOT FOUND CLOSE c_test_case;
		LOOP
			FETCH c_test_case INTO l_routine_name, l_routine_comment;
			
			-- Remember the routine’s name - we’ll need it to log the results
			SET @_fab_routine_comment := l_routine_comment;

			-- Run any set-up scripts
			OPEN c_set_up;
			BEGIN
				DECLARE l_set_up_routine TEXT;
				DECLARE EXIT HANDLER FOR NOT FOUND CLOSE c_set_up;
				LOOP
					FETCH c_set_up INTO l_set_up_routine;
					CALL execute_immediate(CONCAT('CALL ', p_schema, '.', l_set_up_routine));
				END LOOP;
			END;
			-- Run the test script
			CALL execute_immediate(CONCAT('CALL ', p_schema, '.', l_routine_name));

			-- Run any tear-down scripts
			OPEN c_tear_down;
			BEGIN
				DECLARE l_tear_down_routine TEXT;
				DECLARE EXIT HANDLER FOR NOT FOUND CLOSE c_tear_down;
				LOOP
					FETCH c_tear_down INTO l_tear_down_routine;
					CALL execute_immediate(CONCAT('CALL ', p_schema, '.', l_tear_down_routine));
				END LOOP;
			END;

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
			ELSE GROUP_CONCAT(CASE WHEN result THEN NULL ELSE test END SEPARATOR '; ')
		END AS details
	FROM result
	GROUP BY script;

	SELECT
		CASE WHEN MIN(result) THEN 'pass' ELSE 'fail' END AS result,
		COUNT(*) AS tests,
		NOW() - l_start_time AS seconds
	FROM result;
END //

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

DROP TABLE IF EXISTS reserved_word //

CREATE TABLE reserved_word (
	reserved_word VARCHAR(31) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'See https://dev.mysql.com/doc/refman/5.7/en/reserved-words.html',
	PRIMARY KEY (reserved_word)
) COMMENT 'All MySQL reserved words' //

INSERT INTO reserved_word (reserved_word) VALUES
('ACCESSIBLE'),
('ACTION'),
('ADD'),
('ALL'),
('ALTER'),
('ANALYZE'),
('AND'),
('AS'),
('ASC'),
('ASENSITIVE'),
('BEFORE'),
('BETWEEN'),
('BIGINT'),
('BINARY'),
('BIT'),
('BLOB'),
('BOTH'),
('BY'),
('CALL'),
('CASCADE'),
('CASE'),
('CHANGE'),
('CHAR'),
('CHARACTER'),
('CHECK'),
('COLLATE'),
('COLUMN'),
('CONDITION'),
('CONSTRAINT'),
('CONTINUE'),
('CONVERT'),
('CREATE'),
('CROSS'),
('CURRENT_DATE'),
('CURRENT_TIME'),
('CURRENT_TIMESTAMP'),
('CURRENT_USER'),
('CURSOR'),
('DATABASE'),
('DATABASES'),
('DATE'),
('DAY_HOUR'),
('DAY_MICROSECOND'),
('DAY_MINUTE'),
('DAY_SECOND'),
('DEC'),
('DECIMAL'),
('DECLARE'),
('DEFAULT'),
('DELAYED'),
('DELETE'),
('DESC'),
('DESCRIBE'),
('DETERMINISTIC'),
('DISTINCT'),
('DISTINCTROW'),
('DIV'),
('DOUBLE'),
('DROP'),
('DUAL'),
('EACH'),
('ELSE'),
('ELSEIF'),
('ENCLOSED'),
('ENUM'),
('ESCAPED'),
('EXISTS'),
('EXIT'),
('EXPLAIN'),
('FALSE'),
('FETCH'),
('FLOAT'),
('FLOAT4'),
('FLOAT8'),
('FOR'),
('FORCE'),
('FOREIGN'),
('FROM'),
('FULLTEXT'),
('GET'),
('GRANT'),
('GROUP'),
('HAVING'),
('HIGH_PRIORITY'),
('HOUR_MICROSECOND'),
('HOUR_MINUTE'),
('HOUR_SECOND'),
('IF'),
('IGNORE'),
('IN'),
('INDEX'),
('INFILE'),
('INNER'),
('INOUT'),
('INSENSITIVE'),
('INSERT'),
('INT'),
('INT1'),
('INT2'),
('INT3'),
('INT4'),
('INT8'),
('INTEGER'),
('INTERVAL'),
('INTO'),
('IO_AFTER_GTIDS'),
('IO_BEFORE_GTIDS'),
('IS'),
('ITERATE'),
('JOIN'),
('KEY'),
('KEYS'),
('KILL'),
('LEADING'),
('LEAVE'),
('LEFT'),
('LIKE'),
('LIMIT'),
('LINEAR'),
('LINES'),
('LOAD'),
('LOCALTIME'),
('LOCALTIMESTAMP'),
('LOCK'),
('LONG'),
('LONGBLOB'),
('LONGTEXT'),
('LOOP'),
('LOW_PRIORITY'),
('MASTER_BIND'),
('MASTER_SSL_VERIFY_SERVER_CERT'),
('MATCH'),
('MAXVALUE'),
('MEDIUMBLOB'),
('MEDIUMINT'),
('MEDIUMTEXT'),
('MIDDLEINT'),
('MINUTE_MICROSECOND'),
('MINUTE_SECOND'),
('MOD'),
('MODIFIES'),
('NATURAL'),
('NO'),
('NONBLOCKING'),
('NOT'),
('NO_WRITE_TO_BINLOG'),
('NULL'),
('NUMERIC'),
('ON'),
('OPTIMIZE'),
('OPTION'),
('OPTIONALLY'),
('OR'),
('ORDER'),
('OUT'),
('OUTER'),
('OUTFILE'),
('PARTITION'),
('PRECISION'),
('PRIMARY'),
('PROCEDURE'),
('PURGE'),
('RANGE'),
('READ'),
('READS'),
('READ_WRITE'),
('REAL'),
('REFERENCES'),
('REGEXP'),
('RELEASE'),
('RENAME'),
('REPEAT'),
('REPLACE'),
('REQUIRE'),
('RESIGNAL'),
('RESTRICT'),
('RETURN'),
('REVOKE'),
('RIGHT'),
('RLIKE'),
('SCHEMA'),
('SCHEMAS'),
('SECOND_MICROSECOND'),
('SELECT'),
('SENSITIVE'),
('SEPARATOR'),
('SET'),
('SHOW'),
('SIGNAL'),
('SMALLINT'),
('SPATIAL'),
('SPECIFIC'),
('SQL'),
('SQLEXCEPTION'),
('SQLSTATE'),
('SQLWARNING'),
('SQL_BIG_RESULT'),
('SQL_CALC_FOUND_ROWS'),
('SQL_SMALL_RESULT'),
('SSL'),
('STARTING'),
('STRAIGHT_JOIN'),
('TABLE'),
('TERMINATED'),
('TEXT'),
('THEN'),
('TIME'),
('TIMESTAMP'),
('TINYBLOB'),
('TINYINT'),
('TINYTEXT'),
('TO'),
('TRAILING'),
('TRIGGER'),
('TRUE'),
('UNDO'),
('UNION'),
('UNIQUE'),
('UNLOCK'),
('UNSIGNED'),
('UPDATE'),
('USAGE'),
('USE'),
('USING'),
('UTC_DATE'),
('UTC_TIME'),
('UTC_TIMESTAMP'),
('VALUES'),
('VARBINARY'),
('VARCHAR'),
('VARCHARACTER'),
('VARYING'),
('WHEN'),
('WHERE'),
('WHILE'),
('WITH'),
('WRITE'),
('XOR'),
('YEAR_MONTH'),
('ZEROFILL') //

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

DROP TABLE IF EXISTS result //

CREATE TABLE result (
	script VARCHAR(80) NOT NULL COMMENT 'Name of the test script/procedure',
	test   VARCHAR(80) NOT NULL COMMENT 'Description of the test',
	result BOOLEAN     NOT NULL COMMENT 'TRUE=pass, FALSE=fail',
	PRIMARY KEY (script, test)
) COMMENT 'Results of each test' //

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

DROP PROCEDURE IF EXISTS test_assert_column_comments //

CREATE PROCEDURE test_assert_column_comments()
	COMMENT 'Test: assert_column_comments()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_column_comments(DATABASE(), 'reserved_word');
	CALL assert_column_comments(DATABASE(), 'result'       );

	CREATE TABLE foo (bar INTEGER);
	CALL expect_to_fail();
	CALL assert_column_comments(DATABASE(), 'foo');
	DROP TABLE foo;

END //

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

DROP PROCEDURE IF EXISTS test_assert_equals //

CREATE PROCEDURE test_assert_equals()
	COMMENT 'Test: assert_equals()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_equals(TRUE,  TRUE,  'assert_equals(TRUE, TRUE)'  );
	CALL assert_equals(TRUE,  1,     'assert_equals(TRUE, 1)'     );
	CALL assert_equals(TRUE,  '1',   'assert_equals(TRUE, ''1'')' );
	CALL assert_equals(1,     TRUE,  'assert_equals(1, TRUE)'     );
	CALL assert_equals(1,     1,     'assert_equals(1, 1)'        );
	CALL assert_equals(1,     '1',   'assert_equals(1, ''1'')'    );
	CALL assert_equals('1',   TRUE,  'assert_equals(''1'', TRUE)' );
	CALL assert_equals('1',   1,     'assert_equals(''1'', 1)'    );
	CALL assert_equals('1',   '1',   'assert_equals(''1'', ''1'')');

	CALL assert_equals(FALSE, FALSE, 'assert_equals(FALSE, FALSE)');
	CALL assert_equals(FALSE, 0,     'assert_equals(FALSE, 0)'    );
	CALL assert_equals(FALSE, '0',   'assert_equals(FALSE, ''0'')');
	CALL assert_equals(0,     FALSE, 'assert_equals(0, FALSE)'    );
	CALL assert_equals(0,     0,     'assert_equals(0, 0)'        );
	CALL assert_equals(0,     '0',   'assert_equals(0, ''0'')'    );
	CALL assert_equals('0',   FALSE, 'assert_equals(''0'', FALSE)');
	CALL assert_equals('0',   0,     'assert_equals(''0'', 0)'    );
	CALL assert_equals('0',   '0',   'assert_equals(''0'', ''0'')');

	CALL assert_equals(NULL,  NULL,  'assert_equals(NULL, NULL)'  );

	CALL expect_to_fail(); CALL assert_equals(FALSE, TRUE,  'assert_equals(FALSE, TRUE)' );
	CALL expect_to_fail(); CALL assert_equals(FALSE, 1,     'assert_equals(FALSE, 1)'    );
	CALL expect_to_fail(); CALL assert_equals(FALSE, '1',   'assert_equals(FALSE, ''1'')');
	CALL expect_to_fail(); CALL assert_equals(0,     TRUE,  'assert_equals(0, TRUE)'     );
	CALL expect_to_fail(); CALL assert_equals(0,     1,     'assert_equals(0, 1)'        );
	CALL expect_to_fail(); CALL assert_equals(0,     '1',   'assert_equals(0, ''1'')'    );
	CALL expect_to_fail(); CALL assert_equals('0',   TRUE,  'assert_equals(''0'', TRUE)' );
	CALL expect_to_fail(); CALL assert_equals('0',   1,     'assert_equals(''0'', 1)'    );
	CALL expect_to_fail(); CALL assert_equals('0',   '1',   'assert_equals(''0'', ''1'')');

	CALL expect_to_fail(); CALL assert_equals(TRUE,  FALSE, 'assert_equals(TRUE, FALSE)' );
	CALL expect_to_fail(); CALL assert_equals(TRUE,  0,     'assert_equals(TRUE, 0)'     );
	CALL expect_to_fail(); CALL assert_equals(TRUE,  '0',   'assert_equals(TRUE, ''0'')' );
	CALL expect_to_fail(); CALL assert_equals(1,     FALSE, 'assert_equals(1, FALSE)'    );
	CALL expect_to_fail(); CALL assert_equals(1,     0,     'assert_equals(1, 0)'        );
	CALL expect_to_fail(); CALL assert_equals(1,     '0',   'assert_equals(1, ''0'')'    );
	CALL expect_to_fail(); CALL assert_equals('1',   FALSE, 'assert_equals(''1'', FALSE)');
	CALL expect_to_fail(); CALL assert_equals('1',   0,     'assert_equals(''1'', 0)'    );
	CALL expect_to_fail(); CALL assert_equals('1',   '0',   'assert_equals(''1'', ''0'')');

	CALL expect_to_fail(); CALL assert_equals(NULL,  FALSE, 'assert_equals(NULL, FALSE)' );
	CALL expect_to_fail(); CALL assert_equals(NULL,  TRUE,  'assert_equals(NULL, TRUE)'  );
	CALL expect_to_fail(); CALL assert_equals(NULL,  0,     'assert_equals(NULL, 0)'     );
	CALL expect_to_fail(); CALL assert_equals(NULL,  1,     'assert_equals(NULL, 1)'     );
	CALL expect_to_fail(); CALL assert_equals(FALSE, NULL,  'assert_equals(FALSE, NULL)' );
	CALL expect_to_fail(); CALL assert_equals(TRUE,  NULL,  'assert_equals(TRUE, NULL)'  );
	CALL expect_to_fail(); CALL assert_equals(0,     NULL,  'assert_equals(0, NULL)'     );
	CALL expect_to_fail(); CALL assert_equals(1,     NULL,  'assert_equals(1, NULL)'     );
END //

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

DROP PROCEDURE IF EXISTS test_assert_false //

CREATE PROCEDURE test_assert_false()
	COMMENT 'Test: assert_false()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_false(FALSE, 'assert_false(FALSE)');
	CALL assert_false(0,     'assert_false(0)'    );
	CALL assert_false('0',   'assert_false(''0'')');

	CALL expect_to_fail(); CALL assert_false(TRUE, 'assert_false(TRUE)' );
	CALL expect_to_fail(); CALL assert_false(1,    'assert_false(1)'    );
	CALL expect_to_fail(); CALL assert_false('1',  'assert_false(''1'')');
	CALL expect_to_fail(); CALL assert_false(-1,   'assert_false(-1)'   );
END //

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

DROP PROCEDURE IF EXISTS test_assert_like_escape //

CREATE PROCEDURE test_assert_like_escape()
	COMMENT 'Test: assert_like_escape()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_like_escape('foo', 'foo',   '!', 'assert_like_escape(''foo'',''foo'', ''!'')'  );
	CALL assert_like_escape('foo', 'fo_',   '!', 'assert_like_escape(''foo'',''fo_'', ''!'')'  );
	CALL assert_like_escape('foo', 'f_o',   '!', 'assert_like_escape(''foo'',''f_o'', ''!'')'  );
	CALL assert_like_escape('foo', '_oo',   '!', 'assert_like_escape(''foo'',''_oo'', ''!'')'  );
	CALL assert_like_escape('foo', '_o_',   '!', 'assert_like_escape(''foo'',''_o_'', ''!'')'  );
	CALL assert_like_escape('foo', '%',     '!', 'assert_like_escape(''foo'',''%'', ''!'')'    );
	CALL assert_like_escape('foo', 'f%',    '!', 'assert_like_escape(''foo'',''f%'', ''!'')'   );
	CALL assert_like_escape('foo', '%o',    '!', 'assert_like_escape(''foo'',''%o'', ''!'')'   );

	CALL assert_like_escape('foo', '!foo',  '!', 'assert_like_escape(''foo'',''!foo'', ''!'')' );
	CALL assert_like_escape('foo', '!fo_',  '!', 'assert_like_escape(''foo'',''!fo_'', ''!'')' );
	CALL assert_like_escape('foo', 'f_!o',  '!', 'assert_like_escape(''foo'',''f_!o'', ''!'')' );
	CALL assert_like_escape('foo', '_!o!o', '!', 'assert_like_escape(''foo'',''_!o!o'', ''!'')');
	CALL assert_like_escape('foo', '_!o_',  '!', 'assert_like_escape(''foo'',''_!o_'', ''!'')' );
	CALL assert_like_escape('foo', '!f%',   '!', 'assert_like_escape(''foo'',''!f%'', ''!'')'  );
	CALL assert_like_escape('foo', '%!o',   '!', 'assert_like_escape(''foo'',''%!o'', ''!'')'  );

	CALL expect_to_fail; CALL assert_like_escape('foo', 'fo!_', '!', 'assert_like_escape(''foo'',''bo!_'', ''!'')' );
	CALL expect_to_fail; CALL assert_like_escape('foo', 'f!_o', '!', 'assert_like_escape(''foo'',''b!_o'', ''!'')' );
	CALL expect_to_fail; CALL assert_like_escape('foo', '!_or', '!', 'assert_like_escape(''foo'',''!_oo'', ''!'')' );
	CALL expect_to_fail; CALL assert_like_escape('foo', '_o!_', '!', 'assert_like_escape(''foo'',''!_o!_'', ''!'')');
	CALL expect_to_fail; CALL assert_like_escape('foo', 'f!%',  '!', 'assert_like_escape(''foo'',''b!%'', ''!'')'  );
	CALL expect_to_fail; CALL assert_like_escape('foo', '!%o',  '!', 'assert_like_escape(''foo'',''!%o'', ''!'')'  );
END //

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

DROP PROCEDURE IF EXISTS test_assert_like //

CREATE PROCEDURE test_assert_like()
	COMMENT 'Test: assert_like()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_like('foo', 'foo', 'assert_like(''foo'',''foo'')');
	CALL assert_like('foo', 'fo_', 'assert_like(''foo'',''fo_'')');
	CALL assert_like('foo', 'f_o', 'assert_like(''foo'',''f_o'')');
	CALL assert_like('foo', '_oo', 'assert_like(''foo'',''_oo'')');
	CALL assert_like('foo', '_o_', 'assert_like(''foo'',''_o_'')');
	CALL assert_like('foo', '%',   'assert_like(''foo'',''%'')'  );
	CALL assert_like('foo', 'f%',  'assert_like(''foo'',''f%'')' );
	CALL assert_like('foo', '%o',  'assert_like(''foo'',''%o'')' );

	CALL expect_to_fail; CALL assert_like('foo', 'bar', 'assert_like(''foo'',''bar'')');
	CALL expect_to_fail; CALL assert_like('foo', 'ba_', 'assert_like(''foo'',''ba_'')');
	CALL expect_to_fail; CALL assert_like('foo', 'b_r', 'assert_like(''foo'',''b_r'')');
	CALL expect_to_fail; CALL assert_like('foo', '_ar', 'assert_like(''foo'',''_ar'')');
	CALL expect_to_fail; CALL assert_like('foo', '_a_', 'assert_like(''foo'',''_a_'')');
	CALL expect_to_fail; CALL assert_like('foo', 'b%',  'assert_like(''foo'',''b%'')' );
	CALL expect_to_fail; CALL assert_like('foo', '%r',  'assert_like(''foo'',''%r'')' );
END //

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

DROP PROCEDURE IF EXISTS test_assert_no_reserved_words //

CREATE PROCEDURE test_assert_no_reserved_words()
	COMMENT 'Test: assert_no_reserved_words()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_no_reserved_words(DATABASE());

	CREATE TABLE `TABLE` (bar INTEGER);
	CALL expect_to_fail();
	CALL assert_no_reserved_words(DATABASE());
	DROP TABLE `TABLE`;

	CREATE TABLE bar (`Column` INTEGER);
	CALL expect_to_fail();
	CALL assert_no_reserved_words(DATABASE());
	DROP TABLE bar;

	/* TODO: how can we create a failing test case?
	CALL execute_immediate('CREATE PROCEDURE `PROCEDURE` BEGIN END');
	CALL expect_to_fail();
	CALL assert_no_reserved_words(DATABASE());
	CALL execute_immediate('DROP PROCEDURE `PROCEDURE`');
	*/

END //

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

DROP PROCEDURE IF EXISTS test_assert_not_equals //

CREATE PROCEDURE test_assert_not_equals()
	COMMENT 'Test: assert_not_equals()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_not_equals(FALSE, TRUE,  'assert_not_equals(FALSE, TRUE )');
	CALL assert_not_equals(FALSE, 1,     'assert_not_equals(FALSE, 1)'    );
	CALL assert_not_equals(FALSE, '1',   'assert_not_equals(FALSE, ''1'')');
	CALL assert_not_equals(0,     TRUE,  'assert_not_equals(0, TRUE)'     );
	CALL assert_not_equals(0,     1,     'assert_not_equals(0, 1)'        );
	CALL assert_not_equals(0,     '1',   'assert_not_equals(0, ''1'')'    );
	CALL assert_not_equals('0',   TRUE,  'assert_not_equals(''0'', TRUE)' );
	CALL assert_not_equals('0',   1,     'assert_not_equals(''0'', 1)'    );
	CALL assert_not_equals('0',   '1',   'assert_not_equals(''0'', ''1'')');

	CALL assert_not_equals(TRUE,  FALSE, 'assert_not_equals(TRUE, FALSE)' );
	CALL assert_not_equals(TRUE,  0,     'assert_not_equals(TRUE, 0)'     );
	CALL assert_not_equals(TRUE,  '0',   'assert_not_equals(TRUE, ''0'')' );
	CALL assert_not_equals(1,     FALSE, 'assert_not_equals(1, FALSE)'    );
	CALL assert_not_equals(1,     0,     'assert_not_equals(1, 0)'        );
	CALL assert_not_equals(1,     '0',   'assert_not_equals(1, ''0'')'    );
	CALL assert_not_equals('1',   FALSE, 'assert_not_equals(''1'', FALSE)');
	CALL assert_not_equals('1',   0,     'assert_not_equals(''1'', 0)'    );
	CALL assert_not_equals('1',   '0',   'assert_not_equals(''1'', ''0'')');

	CALL assert_not_equals(NULL,  FALSE, 'assert_not_equals(NULL, FALSE)' );
	CALL assert_not_equals(NULL,  TRUE,  'assert_not_equals(NULL, TRUE)'  );
	CALL assert_not_equals(NULL,  0,     'assert_not_equals(NULL, 0)'     );
	CALL assert_not_equals(NULL,  1,     'assert_not_equals(NULL, 1)'     );
	CALL assert_not_equals(FALSE, NULL,  'assert_not_equals(FALSE, NULL)' );
	CALL assert_not_equals(TRUE,  NULL,  'assert_not_equals(TRUE, NULL)'  );
	CALL assert_not_equals(0,     NULL,  'assert_not_equals(0, NULL)'     );
	CALL assert_not_equals(1,     NULL,  'assert_not_equals(1, NULL)'     );
	
	CALL expect_to_fail(); CALL assert_not_equals(TRUE,  TRUE,  'assert_not_equals(TRUE, TRUE)'  );
	CALL expect_to_fail(); CALL assert_not_equals(TRUE,  1,     'assert_not_equals(TRUE, 1)'     );
	CALL expect_to_fail(); CALL assert_not_equals(TRUE,  '1',   'assert_not_equals(TRUE, ''1'')' );
	CALL expect_to_fail(); CALL assert_not_equals(1,     TRUE,  'assert_not_equals(1, TRUE)'     );
	CALL expect_to_fail(); CALL assert_not_equals(1,     1,     'assert_not_equals(1, 1)'        );
	CALL expect_to_fail(); CALL assert_not_equals(1,     '1',   'assert_not_equals(1, ''1'')'    );
	CALL expect_to_fail(); CALL assert_not_equals('1',   TRUE,  'assert_not_equals(''1'', TRUE )');
	CALL expect_to_fail(); CALL assert_not_equals('1',   1,     'assert_not_equals(''1'', 1)'    );
	CALL expect_to_fail(); CALL assert_not_equals('1',   '1',   'assert_not_equals(''1'', ''1'')');

	CALL expect_to_fail(); CALL assert_not_equals(FALSE, FALSE, 'assert_not_equals(FALSE, FALSE)');
	CALL expect_to_fail(); CALL assert_not_equals(FALSE, 0,     'assert_not_equals(FALSE, 0)'    );
	CALL expect_to_fail(); CALL assert_not_equals(FALSE, '0',   'assert_not_equals(FALSE, ''0'')');
	CALL expect_to_fail(); CALL assert_not_equals(0,     FALSE, 'assert_not_equals(0, FALSE)'    );
	CALL expect_to_fail(); CALL assert_not_equals(0,     0,     'assert_not_equals(0, 0)'        );
	CALL expect_to_fail(); CALL assert_not_equals(0,     '0',   'assert_not_equals(0, ''0'')'    );
	CALL expect_to_fail(); CALL assert_not_equals('0',   FALSE, 'assert_not_equals(''0'', FALSE)');
	CALL expect_to_fail(); CALL assert_not_equals('0',   0,     'assert_not_equals(''0'', 0)'    );
	CALL expect_to_fail(); CALL assert_not_equals('0',   '0',   'assert_not_equals(''0'', ''0'')');

	CALL expect_to_fail(); CALL assert_not_equals(NULL,  NULL,  'assert_not_equals(NULL,  NULL )');
END //

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

DROP PROCEDURE IF EXISTS test_assert_not_like_escape //

CREATE PROCEDURE test_assert_not_like_escape()
	COMMENT 'Test: assert_not_like_escape()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_not_like_escape('foo', 'bar',   '!', 'assert_not_like_escape(''foo'',''bar'', ''!'')');
	CALL assert_not_like_escape('foo', 'ba_',   '!', 'assert_not_like_escape(''foo'',''ba_'', ''!'')');
	CALL assert_not_like_escape('foo', 'b_r',   '!', 'assert_not_like_escape(''foo'',''b_r'', ''!'')');
	CALL assert_not_like_escape('foo', '_ar',   '!', 'assert_not_like_escape(''foo'',''_ar'', ''!'')');
	CALL assert_not_like_escape('foo', '_a_',   '!', 'assert_not_like_escape(''foo'',''_a_'', ''!'')');
	CALL assert_not_like_escape('foo', 'b%',    '!', 'assert_not_like_escape(''foo'',''b%'', ''!'')' );
	CALL assert_not_like_escape('foo', '%r',    '!', 'assert_not_like_escape(''foo'',''%r'', ''!'')' );

	CALL assert_not_like_escape('foo', '!bar',  '!', 'assert_not_like_escape(''foo'',''bar'', ''!'')');
	CALL assert_not_like_escape('foo', '!ba_',  '!', 'assert_not_like_escape(''foo'',''ba_'', ''!'')');
	CALL assert_not_like_escape('foo', 'b_!r',  '!', 'assert_not_like_escape(''foo'',''b_r'', ''!'')');
	CALL assert_not_like_escape('foo', '_!a!r', '!', 'assert_not_like_escape(''foo'',''_ar'', ''!'')');
	CALL assert_not_like_escape('foo', '_!a_',  '!', 'assert_not_like_escape(''foo'',''_a_'', ''!'')');
	CALL assert_not_like_escape('foo', '!b%',   '!', 'assert_not_like_escape(''foo'',''b%'', ''!'')' );
	CALL assert_not_like_escape('foo', '%!r',   '!', 'assert_not_like_escape(''foo'',''%r'', ''!'')' );

	CALL expect_to_fail; CALL assert_not_like_escape('fo_', 'fo!_',  '!', 'assert_not_like_escape(''fo_'',''fo!_'', ''!'')' );
	CALL expect_to_fail; CALL assert_not_like_escape('f_o', 'f!_o',  '!', 'assert_not_like_escape(''f_o'',''f!_o'', ''!'')' );
	CALL expect_to_fail; CALL assert_not_like_escape('_oo', '!_oo',  '!', 'assert_not_like_escape(''_oo'',''!_oo'', ''!'')' );
	CALL expect_to_fail; CALL assert_not_like_escape('_o_', '!_o!_', '!', 'assert_not_like_escape(''_o_'',''!_o!_'', ''!'')');
	CALL expect_to_fail; CALL assert_not_like_escape('f%',  'f!%',   '!', 'assert_not_like_escape(''f%'',''f!%'', ''!'')'   );
	CALL expect_to_fail; CALL assert_not_like_escape('%o',  '!%o',   '!', 'assert_not_like_escape(''%o'',''!%o'', ''!'')'   );
END //

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

DROP PROCEDURE IF EXISTS test_assert_not_like //

CREATE PROCEDURE test_assert_not_like()
	COMMENT 'Test: assert_not_like()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_not_like('foo', 'bar', 'assert_not_like(''foo'',''bar'')');
	CALL assert_not_like('foo', 'ba_', 'assert_not_like(''foo'',''ba_'')');
	CALL assert_not_like('foo', 'b_r', 'assert_not_like(''foo'',''b_r'')');
	CALL assert_not_like('foo', '_ar', 'assert_not_like(''foo'',''_ar'')');
	CALL assert_not_like('foo', '_a_', 'assert_not_like(''foo'',''_a_'')');
	CALL assert_not_like('foo', 'b%',  'assert_not_like(''foo'',''b%'')' );
	CALL assert_not_like('foo', '%r',  'assert_not_like(''foo'',''%r'')' );

	CALL expect_to_fail; CALL assert_not_like('foo', 'foo', 'assert_not_like(''foo'',''foo'')');
	CALL expect_to_fail; CALL assert_not_like('foo', 'fo_', 'assert_not_like(''foo'',''fo_'')');
	CALL expect_to_fail; CALL assert_not_like('foo', 'f_o', 'assert_not_like(''foo'',''f_o'')');
	CALL expect_to_fail; CALL assert_not_like('foo', '_oo', 'assert_not_like(''foo'',''_oo'')');
	CALL expect_to_fail; CALL assert_not_like('foo', '_o_', 'assert_not_like(''foo'',''_o_'')');
	CALL expect_to_fail; CALL assert_not_like('foo', '%',   'assert_not_like(''foo'',''%'')'  );
	CALL expect_to_fail; CALL assert_not_like('foo', 'f%',  'assert_not_like(''foo'',''f%'')' );
	CALL expect_to_fail; CALL assert_not_like('foo', '%o',  'assert_not_like(''foo'',''%o'')' );
END //

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

DROP PROCEDURE IF EXISTS test_assert_not_null //

CREATE PROCEDURE test_assert_not_null()
	COMMENT 'Test: assert_not_null()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_not_null(FALSE, 'assert_not_null(FALSE)');
	CALL assert_not_null(TRUE,  'assert_not_null(TRUE)' );
	CALL assert_not_null(0,     'assert_not_null(0)'    );
	CALL assert_not_null(1,     'assert_not_null(1)'    );
	CALL assert_not_null('0',   'assert_not_null(''0'')');
	CALL assert_not_null('1',   'assert_not_null(''1'')');

	CALL expect_to_fail; CALL assert_not_null(NULL, 'assert_not_null(NULL)');
END //

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

DROP PROCEDURE IF EXISTS test_assert_not_regexp //

CREATE PROCEDURE test_assert_not_regexp()
	COMMENT 'Test: assert_not_regexp()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_not_regexp('FOO', 'foo', 'assert_not_regexp(''FOO'',''foo'')');
	CALL assert_not_regexp('FOO', 'foo', 'assert_not_regexp(''FOO'',''foo'')');
	CALL assert_not_regexp('FOO', 'fo.', 'assert_not_regexp(''FOO'',''fo.'')');
	CALL assert_not_regexp('FOO', 'f.o', 'assert_not_regexp(''FOO'',''f.o'')');
	CALL assert_not_regexp('FOO', '.oo', 'assert_not_regexp(''FOO'',''.oo'')');
	CALL assert_not_regexp('FOO', '.o+', 'assert_not_regexp(''FOO'',''.o+'')');
	CALL assert_not_regexp('FOO', 'fo*', 'assert_not_regexp(''FOO'',''fo*'')');
	CALL assert_not_regexp('FOO', '.*o', 'assert_not_regexp(''FOO'',''.*o'')');

	CALL assert_not_regexp('bar', 'foo', 'assert_not_regexp(''bar'',''foo'')');
	CALL assert_not_regexp('bar', 'foo', 'assert_not_regexp(''bar'',''foo'')');
	CALL assert_not_regexp('bar', 'fo.', 'assert_not_regexp(''bar'',''fo.'')');
	CALL assert_not_regexp('bar', 'f.o', 'assert_not_regexp(''bar'',''f.o'')');
	CALL assert_not_regexp('bar', '.oo', 'assert_not_regexp(''bar'',''.oo'')');
	CALL assert_not_regexp('bar', '.o+', 'assert_not_regexp(''bar'',''.o+'')');
	CALL assert_not_regexp('bar', 'fo*', 'assert_not_regexp(''bar'',''fo*'')');
	CALL assert_not_regexp('bar', '.*o', 'assert_not_regexp(''bar'',''.*o'')');

	CALL expect_to_fail; CALL assert_not_regexp('foo', 'foo', 'assert_not_regexp(''foo'',''foo'')');
	CALL expect_to_fail; CALL assert_not_regexp('foo', 'foo', 'assert_not_regexp(''foo'',''foo'')');
	CALL expect_to_fail; CALL assert_not_regexp('foo', 'fo.', 'assert_not_regexp(''foo'',''fo.'')');
	CALL expect_to_fail; CALL assert_not_regexp('foo', 'f.o', 'assert_not_regexp(''foo'',''f.o'')');
	CALL expect_to_fail; CALL assert_not_regexp('foo', '.oo', 'assert_not_regexp(''foo'',''.oo'')');
	CALL expect_to_fail; CALL assert_not_regexp('foo', '.o+', 'assert_not_regexp(''foo'',''.o+'')');
	CALL expect_to_fail; CALL assert_not_regexp('foo', '.*',  'assert_not_regexp(''foo'',''.*'')' );
	CALL expect_to_fail; CALL assert_not_regexp('foo', 'fo*', 'assert_not_regexp(''foo'',''fo*'')');
	CALL expect_to_fail; CALL assert_not_regexp('foo', '.*o', 'assert_not_regexp(''foo'',''.*o'')');
END //

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

DROP PROCEDURE IF EXISTS test_assert_null //

CREATE PROCEDURE test_assert_null()
	COMMENT 'Test: assert_null()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_null(NULL, 'assert_null(NULL)');

	CALL expect_to_fail; CALL assert_null(FALSE, 'assert_null(FALSE)');
	CALL expect_to_fail; CALL assert_null(TRUE,  'assert_null(TRUE)' );
	CALL expect_to_fail; CALL assert_null(0,     'assert_null(0)'    );
	CALL expect_to_fail; CALL assert_null(1,     'assert_null(1)'    );
	CALL expect_to_fail; CALL assert_null('0',   'assert_null(''0'')');
	CALL expect_to_fail; CALL assert_null('1',   'assert_null(''1'')');
END //

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

DROP PROCEDURE IF EXISTS test_assert_regexp //

CREATE PROCEDURE test_assert_regexp()
	COMMENT 'Test: assert_regexp()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_regexp('foo', 'foo', 'assert_regexp(''foo'',''foo'')');
	CALL assert_regexp('foo', 'foo', 'assert_regexp(''foo'',''foo'')');
	CALL assert_regexp('foo', 'fo.', 'assert_regexp(''foo'',''fo.'')');
	CALL assert_regexp('foo', 'f.o', 'assert_regexp(''foo'',''f.o'')');
	CALL assert_regexp('foo', '.oo', 'assert_regexp(''foo'',''.oo'')');
	CALL assert_regexp('foo', '.o+', 'assert_regexp(''foo'',''.o+'')');
	CALL assert_regexp('foo', '.*',  'assert_regexp(''foo'',''.*'')' );
	CALL assert_regexp('foo', 'fo*', 'assert_regexp(''foo'',''fo*'')');
	CALL assert_regexp('foo', '.*o', 'assert_regexp(''foo'',''.*o'')');

	CALL expect_to_fail; CALL assert_regexp('FOO', 'foo', 'assert_regexp(''FOO'',''foo'')');
	CALL expect_to_fail; CALL assert_regexp('FOO', 'foo', 'assert_regexp(''FOO'',''foo'')');
	CALL expect_to_fail; CALL assert_regexp('FOO', 'fo.', 'assert_regexp(''FOO'',''fo.'')');
	CALL expect_to_fail; CALL assert_regexp('FOO', 'f.o', 'assert_regexp(''FOO'',''f.o'')');
	CALL expect_to_fail; CALL assert_regexp('FOO', '.oo', 'assert_regexp(''FOO'',''.oo'')');
	CALL expect_to_fail; CALL assert_regexp('FOO', '.o+', 'assert_regexp(''FOO'',''.o+'')');
	CALL expect_to_fail; CALL assert_regexp('FOO', 'fo*', 'assert_regexp(''FOO'',''fo*'')');
	CALL expect_to_fail; CALL assert_regexp('FOO', '.*o', 'assert_regexp(''FOO'',''.*o'')');

	CALL expect_to_fail; CALL assert_regexp('bar', 'foo', 'assert_regexp(''bar'',''foo'')');
	CALL expect_to_fail; CALL assert_regexp('bar', 'foo', 'assert_regexp(''bar'',''foo'')');
	CALL expect_to_fail; CALL assert_regexp('bar', 'fo.', 'assert_regexp(''bar'',''fo.'')');
	CALL expect_to_fail; CALL assert_regexp('bar', 'f.o', 'assert_regexp(''bar'',''f.o'')');
	CALL expect_to_fail; CALL assert_regexp('bar', '.oo', 'assert_regexp(''bar'',''.oo'')');
	CALL expect_to_fail; CALL assert_regexp('bar', '.o+', 'assert_regexp(''bar'',''.o+'')');
	CALL expect_to_fail; CALL assert_regexp('bar', 'fo*', 'assert_regexp(''bar'',''fo*'')');
	CALL expect_to_fail; CALL assert_regexp('bar', '.*o', 'assert_regexp(''bar'',''.*o'')');
END //

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

DROP PROCEDURE IF EXISTS test_assert_routine_comments //

CREATE PROCEDURE test_assert_routine_comments()
	COMMENT 'Test: assert_routine_comments()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_routine_comments(DATABASE());

	/* TODO: how can we create a failing test case?
	CALL execute_immediate('CREATE PROCEDURE `PROCEDURE` BEGIN END');
	CALL expect_to_fail();
	CALL assert_no_reserved_words(DATABASE());
	CALL execute_immediate('DROP PROCEDURE `PROCEDURE`');
	*/

END //

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
--
-- NOTE: test_assert_true() is identical to this test

DROP PROCEDURE IF EXISTS test_assert //

CREATE PROCEDURE test_assert()
	COMMENT 'Test: assert()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert(TRUE, 'assert(TRUE)' );
	CALL assert(1,    'assert(1)'    );
	CALL assert(-1,   'assert(-1)'   );
	CALL assert('1',  'assert(''1'')');

	CALL expect_to_fail; CALL assert(FALSE, 'assert(FALSE)');
	CALL expect_to_fail; CALL assert(0,     'assert(0)'    );
	CALL expect_to_fail; CALL assert('0',   'assert(''0'')');
END //

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

DROP PROCEDURE IF EXISTS test_assert_table_comments //

CREATE PROCEDURE test_assert_table_comments()
	COMMENT 'Test: assert_table_comments()'
	LANGUAGE SQL
	DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	CALL assert_table_comments(DATABASE(), 'reserved_word');
	CALL assert_table_comments(DATABASE(), 'result'       );

	CREATE TABLE foo (bar INTEGER);
	CALL expect_to_fail();
	CALL assert_table_comments(DATABASE(), 'foo');
	DROP TABLE foo;

END //

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
--
-- NOTE: This test is identical to test_assert()

DROP PROCEDURE IF EXISTS test_assert_true //

CREATE PROCEDURE test_assert_true()
	COMMENT 'Test: assert_true()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert(TRUE, 'assert_true(TRUE)' );
	CALL assert(1,    'assert_true(1)'    );
	CALL assert(-1,   'assert_true(-1)'   );
	CALL assert('1',  'assert_true(''1'')');

	CALL expect_to_fail; CALL assert_true(FALSE, 'assert_true(FALSE)');
	CALL expect_to_fail; CALL assert_true(0,     'assert_true(0)'    );
	CALL expect_to_fail; CALL assert_true('0',   'assert_true(''0'')');
END //

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

DROP PROCEDURE IF EXISTS test_coverage //

CREATE PROCEDURE test_coverage()
	COMMENT 'Test: coverage of unit tests'
	LANGUAGE SQL
	DETERMINISTIC
	READS SQL DATA
	SQL SECURITY DEFINER
BEGIN
	DECLARE l_routine TEXT;

	DECLARE c_coverage CURSOR FOR
	SELECT r1.routine_name
	FROM       information_schema.routines r1
	LEFT JOIN  information_schema.routines r2 ON (r1.routine_schema=r2.routine_schema AND r2.routine_name = CONCAT('test_', r1.routine_name))
	WHERE  r1.routine_schema = DATABASE()
	AND    r1.routine_name LIKE 'assert_%'
	AND    r2.routine_name IS NULL;

	OPEN c_coverage;
	BEGIN
		DECLARE EXIT HANDLER FOR NOT FOUND CLOSE c_coverage;
		LOOP
			FETCH c_coverage INTO l_routine;
			CALL assert(FALSE, CONCAT('No test script for ', l_routine, '()'));
		END LOOP;
	END;

	IF l_routine IS NULL THEN
		CALL assert(TRUE, 'All assertions have test scripts');
	END IF;
END //

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

DROP PROCEDURE IF EXISTS test_set_up_foo_bar_baz_set_up //

CREATE PROCEDURE test_set_up_foo_bar_baz_set_up()
	COMMENT 'Test: set-up and tear-down'
	LANGUAGE SQL
	DETERMINISTIC
	READS SQL DATA
	SQL SECURITY DEFINER
BEGIN
	CALL assert_true(@_fab_test_set_up_foo_set_up,     'test_set_up_foo_set_up before test_set_up_foo_bar_baz_set_up');
	CALL assert_true(@_fab_test_set_up_foo_bar_set_up, 'test_set_up_foo_bar_set_up before test_set_up_foo_bar_baz_set_up');
	SET @_fab_test_set_up_foo_bar_baz_set_up := TRUE;
END //

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

DROP PROCEDURE IF EXISTS test_set_up_foo_bar_baz //

CREATE PROCEDURE test_set_up_foo_bar_baz()
	COMMENT 'Test: set-up and tear-down'
	LANGUAGE SQL
	DETERMINISTIC
	READS SQL DATA
	SQL SECURITY DEFINER
BEGIN
	CALL assert_true(@_fab_test_set_up_foo_set_up,         'Set-up script called for test_set_up_foo');
	CALL assert_true(@_fab_test_set_up_foo_bar_set_up,     'Set-up script called for test_set_up_foo_bar');
	CALL assert_true(@_fab_test_set_up_foo_bar_baz_set_up, 'Set-up script called for test_set_up_foo_bar_baz');
END //

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

DROP PROCEDURE IF EXISTS test_set_up_foo_bar_baz_tear_down //

CREATE PROCEDURE test_set_up_foo_bar_baz_tear_down()
	COMMENT 'Test: set-up and tear-down'
	LANGUAGE SQL
	DETERMINISTIC
	READS SQL DATA
	SQL SECURITY DEFINER
BEGIN
	CALL assert_true(@_fab_test_set_up_foo_bar_baz_set_up, 'test_set_up_foo_bar_baz_set_up() before test_set_up_foo_bar_baz_tear_down()');
	SET @_fab_test_set_up_foo_bar_baz_set_up    := NULL;
END //

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

DROP PROCEDURE IF EXISTS test_set_up_foo_bar_set_up //

CREATE PROCEDURE test_set_up_foo_bar_set_up()
	COMMENT 'Test: set-up and tear-down'
	LANGUAGE SQL
	DETERMINISTIC
	READS SQL DATA
	SQL SECURITY DEFINER
BEGIN
	CALL assert_true(@_fab_test_set_up_foo_set_up, 'Call test_set_up_foo_set_up before test_set_up_foo_bar_set_up');
	SET @_fab_test_set_up_foo_bar_set_up := TRUE;
END //

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

DROP PROCEDURE IF EXISTS test_set_up_foo_bar //

CREATE PROCEDURE test_set_up_foo_bar()
	COMMENT 'Test: set-up and tear-down'
	LANGUAGE SQL
	DETERMINISTIC
	READS SQL DATA
	SQL SECURITY DEFINER
BEGIN
	CALL assert_true(@_fab_test_set_up_foo_set_up,         'Set-up script called for test_set_up_foo');
	CALL assert_true(@_fab_test_set_up_foo_bar_set_up,     'Set-up script called for test_set_up_foo_bar');
END //

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

DROP PROCEDURE IF EXISTS test_set_up_foo_bar_tear_down //

CREATE PROCEDURE test_set_up_foo_bar_tear_down()
	COMMENT 'Test: set-up and tear-down'
	LANGUAGE SQL
	DETERMINISTIC
	READS SQL DATA
	SQL SECURITY DEFINER
BEGIN
	CALL assert_true(@_fab_test_set_up_foo_bar_set_up, 'test_set_up_foo_bar_set_up() before test_set_up_foo_bar_tear_down()');
	SET @_fab_test_set_up_foo_bar_set_up    := NULL;
END //

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

DROP PROCEDURE IF EXISTS test_set_up_foo_set_up //

CREATE PROCEDURE test_set_up_foo_set_up()
	COMMENT 'Test: set-up and tear-down'
	LANGUAGE SQL
	DETERMINISTIC
	READS SQL DATA
	SQL SECURITY DEFINER
BEGIN
	CALL assert_null(@_fab_test_set_up_foo_set_up, '@_fab_test_set_up_foo_set_up is null before we start');
	SET @_fab_test_set_up_foo_set_up := TRUE;
END //

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

DROP PROCEDURE IF EXISTS test_set_up_foo //

CREATE PROCEDURE test_set_up_foo()
	COMMENT 'Test: set-up and tear-down'
	LANGUAGE SQL
	DETERMINISTIC
	READS SQL DATA
	SQL SECURITY DEFINER
BEGIN
	CALL assert_true(@_fab_test_set_up_foo_set_up, 'Set-up script called for test_set_up_foo');
END //

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

DROP PROCEDURE IF EXISTS test_set_up_foo_tear_down //

CREATE PROCEDURE test_set_up_foo_tear_down()
	COMMENT 'Test: set-up and tear-down'
	LANGUAGE SQL
	DETERMINISTIC
	READS SQL DATA
	SQL SECURITY DEFINER
BEGIN
	CALL assert_true(@_fab_test_set_up_foo_set_up, 'test_set_up_foo_set_up() before test_set_up_foo_tear_down()');
	SET @_fab_test_set_up_foo_set_up := NULL;
END //

