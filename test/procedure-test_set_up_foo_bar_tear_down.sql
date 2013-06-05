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

DROP PROCEDURE IF EXISTS test_set_up_foo_bar_tear_down //

CREATE PROCEDURE test_set_up_foo_bar_tear_down()
	COMMENT 'Test: set-up and tear-down'
	LANGUAGE SQL
	DETERMINISTIC
	READS SQL DATA
	SQL SECURITY DEFINER
BEGIN
	CALL assert_true(@_fab_test_set_up_foo_bar_set_up, 'test_set_up_foo_bar_set_up() before test_set_up_foo_bar_tear_down()');
	SET @_fab_test_set_up_foo_bar_set_up    := NULL;
END //

