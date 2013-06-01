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

DROP PROCEDURE IF EXISTS test_assert_not_like_escape //

CREATE PROCEDURE test_assert_not_like_escape()
	COMMENT 'Test: assert_not_like_escape()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_not_like_escape('foo', 'bar',   '!', 'assert_not_like_escape(''foo'',''bar'', ''!'')');
	CALL assert_not_like_escape('foo', 'ba_',   '!', 'assert_not_like_escape(''foo'',''ba_'', ''!'')');
	CALL assert_not_like_escape('foo', 'b_r',   '!', 'assert_not_like_escape(''foo'',''b_r'', ''!'')');
	CALL assert_not_like_escape('foo', '_ar',   '!', 'assert_not_like_escape(''foo'',''_ar'', ''!'')');
	CALL assert_not_like_escape('foo', '_a_',   '!', 'assert_not_like_escape(''foo'',''_a_'', ''!'')');
	CALL assert_not_like_escape('foo', 'b%',    '!', 'assert_not_like_escape(''foo'',''b%'', ''!'')' );
	CALL assert_not_like_escape('foo', '%r',    '!', 'assert_not_like_escape(''foo'',''%r'', ''!'')' );

	CALL assert_not_like_escape('foo', '!bar',  '!', 'assert_not_like_escape(''foo'',''bar'', ''!'')');
	CALL assert_not_like_escape('foo', '!ba_',  '!', 'assert_not_like_escape(''foo'',''ba_'', ''!'')');
	CALL assert_not_like_escape('foo', 'b_!r',  '!', 'assert_not_like_escape(''foo'',''b_r'', ''!'')');
	CALL assert_not_like_escape('foo', '_!a!r', '!', 'assert_not_like_escape(''foo'',''_ar'', ''!'')');
	CALL assert_not_like_escape('foo', '_!a_',  '!', 'assert_not_like_escape(''foo'',''_a_'', ''!'')');
	CALL assert_not_like_escape('foo', '!b%',   '!', 'assert_not_like_escape(''foo'',''b%'', ''!'')' );
	CALL assert_not_like_escape('foo', '%!r',   '!', 'assert_not_like_escape(''foo'',''%r'', ''!'')' );

	CALL expect_to_fail; CALL assert_not_like_escape('fo_', 'fo!_',  '!', 'assert_not_like_escape(''fo_'',''fo!_'', ''!'')' );
	CALL expect_to_fail; CALL assert_not_like_escape('f_o', 'f!_o',  '!', 'assert_not_like_escape(''f_o'',''f!_o'', ''!'')' );
	CALL expect_to_fail; CALL assert_not_like_escape('_oo', '!_oo',  '!', 'assert_not_like_escape(''_oo'',''!_oo'', ''!'')' );
	CALL expect_to_fail; CALL assert_not_like_escape('_o_', '!_o!_', '!', 'assert_not_like_escape(''_o_'',''!_o!_'', ''!'')');
	CALL expect_to_fail; CALL assert_not_like_escape('f%',  'f!%',   '!', 'assert_not_like_escape(''f%'',''f!%'', ''!'')'   );
	CALL expect_to_fail; CALL assert_not_like_escape('%o',  '!%o',   '!', 'assert_not_like_escape(''%o'',''!%o'', ''!'')'   );
END //

