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

DROP PROCEDURE IF EXISTS test_assert_regexp //

CREATE PROCEDURE test_assert_regexp()
	COMMENT 'Test: assert_regexp()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_regexp('foo', 'foo', 'assert_regexp(''foo'',''foo'')');
	CALL assert_regexp('foo', 'foo', 'assert_regexp(''foo'',''foo'')');
	CALL assert_regexp('foo', 'fo.', 'assert_regexp(''foo'',''fo.'')');
	CALL assert_regexp('foo', 'f.o', 'assert_regexp(''foo'',''f.o'')');
	CALL assert_regexp('foo', '.oo', 'assert_regexp(''foo'',''.oo'')');
	CALL assert_regexp('foo', '.o+', 'assert_regexp(''foo'',''.o+'')');
	CALL assert_regexp('foo', '.*',  'assert_regexp(''foo'',''.*'')' );
	CALL assert_regexp('foo', 'fo*', 'assert_regexp(''foo'',''fo*'')');
	CALL assert_regexp('foo', '.*o', 'assert_regexp(''foo'',''.*o'')');

	CALL expect_to_fail; CALL assert_regexp('FOO', 'foo', 'assert_regexp(''FOO'',''foo'')');
	CALL expect_to_fail; CALL assert_regexp('FOO', 'foo', 'assert_regexp(''FOO'',''foo'')');
	CALL expect_to_fail; CALL assert_regexp('FOO', 'fo.', 'assert_regexp(''FOO'',''fo.'')');
	CALL expect_to_fail; CALL assert_regexp('FOO', 'f.o', 'assert_regexp(''FOO'',''f.o'')');
	CALL expect_to_fail; CALL assert_regexp('FOO', '.oo', 'assert_regexp(''FOO'',''.oo'')');
	CALL expect_to_fail; CALL assert_regexp('FOO', '.o+', 'assert_regexp(''FOO'',''.o+'')');
	CALL expect_to_fail; CALL assert_regexp('FOO', 'fo*', 'assert_regexp(''FOO'',''fo*'')');
	CALL expect_to_fail; CALL assert_regexp('FOO', '.*o', 'assert_regexp(''FOO'',''.*o'')');

	CALL expect_to_fail; CALL assert_regexp('bar', 'foo', 'assert_regexp(''bar'',''foo'')');
	CALL expect_to_fail; CALL assert_regexp('bar', 'foo', 'assert_regexp(''bar'',''foo'')');
	CALL expect_to_fail; CALL assert_regexp('bar', 'fo.', 'assert_regexp(''bar'',''fo.'')');
	CALL expect_to_fail; CALL assert_regexp('bar', 'f.o', 'assert_regexp(''bar'',''f.o'')');
	CALL expect_to_fail; CALL assert_regexp('bar', '.oo', 'assert_regexp(''bar'',''.oo'')');
	CALL expect_to_fail; CALL assert_regexp('bar', '.o+', 'assert_regexp(''bar'',''.o+'')');
	CALL expect_to_fail; CALL assert_regexp('bar', 'fo*', 'assert_regexp(''bar'',''fo*'')');
	CALL expect_to_fail; CALL assert_regexp('bar', '.*o', 'assert_regexp(''bar'',''.*o'')');
END //

