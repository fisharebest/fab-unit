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

