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

DROP PROCEDURE IF EXISTS test_assert //

CREATE PROCEDURE test_assert()
	COMMENT 'Self-test: assert()'
	LANGUAGE SQL
	NOT DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	CALL assert(TRUE, 'assert(TRUE)' );
	CALL assert(1,    'assert(1)'    );
	CALL assert(-1,   'assert(-1)'   );
	CALL assert('1',  'assert(''1'')');

	CALL expect_to_fail(); CALL assert(FALSE, 'assert(FALSE)');
	CALL expect_to_fail(); CALL assert(0,     'assert(0)'    );
	CALL expect_to_fail(); CALL assert('0',   'assert(''0'')');
END //

