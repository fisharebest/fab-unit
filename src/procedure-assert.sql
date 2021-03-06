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

