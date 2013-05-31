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

DROP PROCEDURE IF EXISTS test_assert_like //

CREATE PROCEDURE test_assert_like()
	COMMENT 'Self-test: assert_like()'
	LANGUAGE SQL
	NOT DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	CALL assert_like('foo', 'foo', 'assert_like(''foo'',''foo'')');
	CALL assert_like('foo', 'fo_', 'assert_like(''foo'',''fo_'')');
	CALL assert_like('foo', 'f_o', 'assert_like(''foo'',''f_o'')');
	CALL assert_like('foo', '_oo', 'assert_like(''foo'',''_oo'')');
	CALL assert_like('foo', '_o_', 'assert_like(''foo'',''_o_'')');
	CALL assert_like('foo', '%',   'assert_like(''foo'',''%'')'  );
	CALL assert_like('foo', 'f%',  'assert_like(''foo'',''f%'')' );
	CALL assert_like('foo', '%o',  'assert_like(''foo'',''%o'')' );

	CALL expect_to_fail; CALL assert_like('foo', 'bar', 'assert_like(''foo'',''bar'')');
	CALL expect_to_fail; CALL assert_like('foo', 'ba_', 'assert_like(''foo'',''ba_'')');
	CALL expect_to_fail; CALL assert_like('foo', 'b_r', 'assert_like(''foo'',''b_r'')');
	CALL expect_to_fail; CALL assert_like('foo', '_ar', 'assert_like(''foo'',''_ar'')');
	CALL expect_to_fail; CALL assert_like('foo', '_a_', 'assert_like(''foo'',''_a_'')');
	CALL expect_to_fail; CALL assert_like('foo', 'b%',  'assert_like(''foo'',''b%'')' );
	CALL expect_to_fail; CALL assert_like('foo', '%r',  'assert_like(''foo'',''%r'')' );
END //
