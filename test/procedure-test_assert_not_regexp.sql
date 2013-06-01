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

DROP PROCEDURE IF EXISTS test_assert_not_regexp //

CREATE PROCEDURE test_assert_not_regexp()
	COMMENT 'Test: assert_not_regexp()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_not_regexp('FOO', 'foo', 'assert_not_regexp(''FOO'',''foo'')');
	CALL assert_not_regexp('FOO', 'foo', 'assert_not_regexp(''FOO'',''foo'')');
	CALL assert_not_regexp('FOO', 'fo.', 'assert_not_regexp(''FOO'',''fo.'')');
	CALL assert_not_regexp('FOO', 'f.o', 'assert_not_regexp(''FOO'',''f.o'')');
	CALL assert_not_regexp('FOO', '.oo', 'assert_not_regexp(''FOO'',''.oo'')');
	CALL assert_not_regexp('FOO', '.o+', 'assert_not_regexp(''FOO'',''.o+'')');
	CALL assert_not_regexp('FOO', 'fo*', 'assert_not_regexp(''FOO'',''fo*'')');
	CALL assert_not_regexp('FOO', '.*o', 'assert_not_regexp(''FOO'',''.*o'')');

	CALL assert_not_regexp('bar', 'foo', 'assert_not_regexp(''bar'',''foo'')');
	CALL assert_not_regexp('bar', 'foo', 'assert_not_regexp(''bar'',''foo'')');
	CALL assert_not_regexp('bar', 'fo.', 'assert_not_regexp(''bar'',''fo.'')');
	CALL assert_not_regexp('bar', 'f.o', 'assert_not_regexp(''bar'',''f.o'')');
	CALL assert_not_regexp('bar', '.oo', 'assert_not_regexp(''bar'',''.oo'')');
	CALL assert_not_regexp('bar', '.o+', 'assert_not_regexp(''bar'',''.o+'')');
	CALL assert_not_regexp('bar', 'fo*', 'assert_not_regexp(''bar'',''fo*'')');
	CALL assert_not_regexp('bar', '.*o', 'assert_not_regexp(''bar'',''.*o'')');

	CALL expect_to_fail; CALL assert_not_regexp('foo', 'foo', 'assert_not_regexp(''foo'',''foo'')');
	CALL expect_to_fail; CALL assert_not_regexp('foo', 'foo', 'assert_not_regexp(''foo'',''foo'')');
	CALL expect_to_fail; CALL assert_not_regexp('foo', 'fo.', 'assert_not_regexp(''foo'',''fo.'')');
	CALL expect_to_fail; CALL assert_not_regexp('foo', 'f.o', 'assert_not_regexp(''foo'',''f.o'')');
	CALL expect_to_fail; CALL assert_not_regexp('foo', '.oo', 'assert_not_regexp(''foo'',''.oo'')');
	CALL expect_to_fail; CALL assert_not_regexp('foo', '.o+', 'assert_not_regexp(''foo'',''.o+'')');
	CALL expect_to_fail; CALL assert_not_regexp('foo', '.*',  'assert_not_regexp(''foo'',''.*'')' );
	CALL expect_to_fail; CALL assert_not_regexp('foo', 'fo*', 'assert_not_regexp(''foo'',''fo*'')');
	CALL expect_to_fail; CALL assert_not_regexp('foo', '.*o', 'assert_not_regexp(''foo'',''.*o'')');
END //

