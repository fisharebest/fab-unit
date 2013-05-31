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

