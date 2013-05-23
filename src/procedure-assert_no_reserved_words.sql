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

CREATE PROCEDURE assert_no_reserved_words()
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
			CALL fail(l_message);
		END LOOP;
	END;
END //

