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
	autocommit               := FALSE,
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

DROP PROCEDURE IF EXISTS assert_no_reserved_words //

CREATE PROCEDURE assert_no_reserved_words ()
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
		WHERE schema_name = @_fab_schema_name
	UNION
	SELECT CONCAT('Table `', table_schema, '`.`', table_name, '` is a reserved word')
		FROM information_schema.tables
		JOIN fab_unit.reserved_word ON (table_name = reserved_word)
		WHERE table_schema = @_fab_schema_name
	UNION
	SELECT CONCAT('Column `', table_schema, '`.`', table_name, '`.`', column_name, '` is a reserved word')
		FROM information_schema.columns
		JOIN fab_unit.reserved_word ON (column_name = reserved_word)
		WHERE table_schema = @_fab_schema_name;

	OPEN c_reserved_word;
	BEGIN
		DECLARE EXIT HANDLER FOR NOT FOUND CLOSE c_reserved_word;
		LOOP
			FETCH c_reserved_word INTO l_message;
			CALL fab_unit.fail(l_message);
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

DROP PROCEDURE IF EXISTS assert //

CREATE PROCEDURE assert (
	IN p_title  TEXT,
	IN p_result BOOLEAN
)
	COMMENT 'Log the result of an assertion'
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

DROP PROCEDURE IF EXISTS run //

CREATE PROCEDURE run (
	p_schema_name TEXT
)
	COMMENT 'Run the unit tests for current database'
	LANGUAGE SQL
	DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	-- The function DATABASE() is evaulated when the procedure is
	-- compiled, meaning that it refers to the fab_unit schema,
	-- not the one we are testing.  Hence capture it early.
	SET @_fab_schema_name := p_schema_name;

	CALL fab_unit.reserved_words(@_fab_schema_name);
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

COMMIT //
