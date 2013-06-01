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

