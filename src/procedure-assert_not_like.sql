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
	IN p_expression1 LONGBLOB,
	IN p_expression2 LONGBLOB,
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

