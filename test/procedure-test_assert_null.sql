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

DROP PROCEDURE IF EXISTS test_assert_null //

CREATE PROCEDURE test_assert_null()
	COMMENT 'Test: assert_null()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_null(NULL, 'assert_null(NULL)');

	CALL expect_to_fail; CALL assert_null(FALSE, 'assert_null(FALSE)');
	CALL expect_to_fail; CALL assert_null(TRUE,  'assert_null(TRUE)' );
	CALL expect_to_fail; CALL assert_null(0,     'assert_null(0)'    );
	CALL expect_to_fail; CALL assert_null(1,     'assert_null(1)'    );
	CALL expect_to_fail; CALL assert_null('0',   'assert_null(''0'')');
	CALL expect_to_fail; CALL assert_null('1',   'assert_null(''1'')');
	CALL expect_to_fail; CALL assert_null(REPEAT('X', 256*256*256*2), 'assert_not_null(<LONGTEXT>)');
END //

