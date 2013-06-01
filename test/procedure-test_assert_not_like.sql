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

DROP PROCEDURE IF EXISTS test_assert_not_like //

CREATE PROCEDURE test_assert_not_like()
	COMMENT 'Test: assert_not_like()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_not_like('foo', 'bar', 'assert_not_like(''foo'',''bar'')');
	CALL assert_not_like('foo', 'ba_', 'assert_not_like(''foo'',''ba_'')');
	CALL assert_not_like('foo', 'b_r', 'assert_not_like(''foo'',''b_r'')');
	CALL assert_not_like('foo', '_ar', 'assert_not_like(''foo'',''_ar'')');
	CALL assert_not_like('foo', '_a_', 'assert_not_like(''foo'',''_a_'')');
	CALL assert_not_like('foo', 'b%',  'assert_not_like(''foo'',''b%'')' );
	CALL assert_not_like('foo', '%r',  'assert_not_like(''foo'',''%r'')' );

	CALL expect_to_fail; CALL assert_not_like('foo', 'foo', 'assert_not_like(''foo'',''foo'')');
	CALL expect_to_fail; CALL assert_not_like('foo', 'fo_', 'assert_not_like(''foo'',''fo_'')');
	CALL expect_to_fail; CALL assert_not_like('foo', 'f_o', 'assert_not_like(''foo'',''f_o'')');
	CALL expect_to_fail; CALL assert_not_like('foo', '_oo', 'assert_not_like(''foo'',''_oo'')');
	CALL expect_to_fail; CALL assert_not_like('foo', '_o_', 'assert_not_like(''foo'',''_o_'')');
	CALL expect_to_fail; CALL assert_not_like('foo', '%',   'assert_not_like(''foo'',''%'')'  );
	CALL expect_to_fail; CALL assert_not_like('foo', 'f%',  'assert_not_like(''foo'',''f%'')' );
	CALL expect_to_fail; CALL assert_not_like('foo', '%o',  'assert_not_like(''foo'',''%o'')' );
END //

