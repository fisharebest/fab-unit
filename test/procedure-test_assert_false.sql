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

