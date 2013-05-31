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
	IF @_fab_expect_to_fail THEN
		INSERT IGNORE INTO result (script, test, result) VALUES (@_fab_routine_comment, CONCAT('NOT ', p_message), TRUE);
	ELSE
		INSERT IGNORE INTO result (script, test, result) VALUES (@_fab_routine_comment, p_message,                 TRUE);
	END IF;
END //

