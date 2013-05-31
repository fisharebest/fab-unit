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
--
-- NOTE: This test is identical to test_assert()

DROP PROCEDURE IF EXISTS test_assert_true //

CREATE PROCEDURE test_assert_true()
	COMMENT 'Self-test: assert_true()'
	LANGUAGE SQL
	NOT DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	CALL assert(TRUE, 'assert_true(TRUE)' );
	CALL assert(1,    'assert_true(1)'    );
	CALL assert(-1,   'assert_true(-1)'   );
	CALL assert('1',  'assert_true(''1'')');

	CALL expect_to_fail; CALL assert_true(FALSE, 'assert_true(FALSE)');
	CALL expect_to_fail; CALL assert_true(0,     'assert_true(0)'    );
	CALL expect_to_fail; CALL assert_true('0',   'assert_true(''0'')');
END //

