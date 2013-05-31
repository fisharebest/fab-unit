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

DROP PROCEDURE IF EXISTS test_assert_not_null //

CREATE PROCEDURE test_assert_not_null()
	COMMENT 'Self-test: assert_not_null()'
	LANGUAGE SQL
	NOT DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	CALL assert_not_null(FALSE, 'assert_not_null(FALSE)');
	CALL assert_not_null(TRUE,  'assert_not_null(TRUE)' );
	CALL assert_not_null(0,     'assert_not_null(0)'    );
	CALL assert_not_null(1,     'assert_not_null(1)'    );
	CALL assert_not_null('0',   'assert_not_null(''0'')');
	CALL assert_not_null('1',   'assert_not_null(''1'')');

	CALL expect_to_fail; CALL assert_not_null(NULL, 'assert_not_null(NULL)');
END //

