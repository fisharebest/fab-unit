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

CREATE DATABASE IF NOT EXISTS fab_unit COLLATE utf8mb4_general_ci //

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

DROP PROCEDURE IF EXISTS assert_null //

CREATE PROCEDURE assert_null (
	IN p_expression BOOLEAN,
	IN p_message    TEXT
)
	COMMENT 'Assert that a value equates to NULL'
	LANGUAGE SQL
	NOT DETERMINISTIC
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
	SELECT p_message AS fail;
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
	NOT DETERMINISTIC
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

DROP PROCEDURE IF EXISTS assert_not_like //

CREATE PROCEDURE assert_not_like (
	IN p_expression1 BLOB,
	IN p_expression2 BLOB,
	IN p_message     TEXT
)
	COMMENT 'Assert that one expression is not like another'
	LANGUAGE SQL
	NOT DETERMINISTIC
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

DROP PROCEDURE IF EXISTS assert_like //

CREATE PROCEDURE assert_like (
	IN p_expression1 BLOB,
	IN p_expression2 BLOB,
	IN p_message     TEXT
)
	COMMENT 'Assert that one expression is like another'
	LANGUAGE SQL
	NOT DETERMINISTIC
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
	p_schema TEXT
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
			CALL fail(l_message);
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

DROP PROCEDURE IF EXISTS assert_regexp_binary //

CREATE PROCEDURE assert_regexp_binary (
	IN p_expression1 BLOB,
	IN p_expression2 BLOB,
	IN p_message     TEXT
)
	COMMENT 'Assert that an expression matches a case-sensitive regular expression'
	LANGUAGE SQL
	NOT DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	SET p_message := COALESCE(p_message, 'assert_regexp()');
	CALL assert(p_expression1 NOT REGEXP BINARY p_expression2, p_message);
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
	p_schema TEXT
)
	COMMENT 'Check that all tables have comments'
	LANGUAGE SQL
	DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
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
	NOT DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	SET p_message := COALESCE(p_message, 'assert_regexp()');
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
	IF p_expression THEN
		CALL pass(p_message);
	ELSE
		CALL fail(p_message);
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

DROP PROCEDURE IF EXISTS assert_not_equals //

CREATE PROCEDURE assert_not_equals (
	IN p_expression1 BLOB,
	IN p_expression2 BLOB,
	IN p_message     TEXT
)
	COMMENT 'Assert that two values are not equal'
	LANGUAGE SQL
	NOT DETERMINISTIC
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

DROP PROCEDURE IF EXISTS assert_not_regexp_binary //

CREATE PROCEDURE assert_not_regexp_binary (
	IN p_expression1 BLOB,
	IN p_expression2 BLOB,
	IN p_message     TEXT
)
	COMMENT 'Assert that an expression does not match a case-sensitive regular expression'
	LANGUAGE SQL
	NOT DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	SET p_message := COALESCE(p_message, 'assert_not_regexp_binary()');
	CALL assert(p_expression1 NOT REGEXP BINARY p_expression2, p_message);
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

DROP PROCEDURE IF EXISTS assert_column_comments //

CREATE PROCEDURE assert_column_comments(
	p_schema TEXT,
	p_table  TEXT
)
	COMMENT 'Check that all columns have comments'
	LANGUAGE SQL
	DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
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
	NOT DETERMINISTIC
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

DROP PROCEDURE IF EXISTS assert_not_like_escape //

CREATE PROCEDURE assert_not_like_escape (
	IN p_expression1 BLOB,
	IN p_expression2 BLOB,
	IN p_escape      CHAR(1),
	IN p_message     TEXT
)
	COMMENT 'Assert that one expression is not like another'
	LANGUAGE SQL
	NOT DETERMINISTIC
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
	SELECT p_message AS success;
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
	NOT DETERMINISTIC
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

DROP PROCEDURE IF EXISTS assert_like_escape //

CREATE PROCEDURE assert_like_escape (
	IN p_expression1 BLOB,
	IN p_expression2 BLOB,
	IN p_escape      CHAR(1),
	IN p_message     TEXT
)
	COMMENT 'Assert that one expression is like another'
	LANGUAGE SQL
	NOT DETERMINISTIC
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

DROP PROCEDURE IF EXISTS assert_not_regexp //

CREATE PROCEDURE assert_not_regexp (
	IN p_expression1 BLOB,
	IN p_expression2 BLOB,
	IN p_message     TEXT
)
	COMMENT 'Assert that an expression does not match a case-insensitive regular expression'
	LANGUAGE SQL
	NOT DETERMINISTIC
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

DROP PROCEDURE IF EXISTS assert_not_null //

CREATE PROCEDURE assert_not_null (
	IN p_expression BOOLEAN,
	IN p_message    TEXT
)
	COMMENT 'Assert that a value does not equate to NULL'
	LANGUAGE SQL
	NOT DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	SET p_message := COALESCE(p_message, 'assert_not_null()');
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

DROP TABLE IF EXISTS reserved_word //

CREATE TABLE reserved_word (
	reserved_word VARCHAR(31) COLLATE utf8mb4_general_ci NOT NULL,
	PRIMARY KEY (reserved_word)
) //

-- See https://dev.mysql.com/doc/refman/5.7/en/reserved-words.html
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

CALL fab_unit.run(database(), null) //

