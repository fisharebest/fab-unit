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

DROP PROCEDURE IF EXISTS test_assert_like_escape //

CREATE PROCEDURE test_assert_like_escape()
	COMMENT 'Test: assert_like_escape()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_like_escape('foo', 'foo',   '!', 'assert_like_escape(''foo'',''foo'', ''!'')'  );
	CALL assert_like_escape('foo', 'fo_',   '!', 'assert_like_escape(''foo'',''fo_'', ''!'')'  );
	CALL assert_like_escape('foo', 'f_o',   '!', 'assert_like_escape(''foo'',''f_o'', ''!'')'  );
	CALL assert_like_escape('foo', '_oo',   '!', 'assert_like_escape(''foo'',''_oo'', ''!'')'  );
	CALL assert_like_escape('foo', '_o_',   '!', 'assert_like_escape(''foo'',''_o_'', ''!'')'  );
	CALL assert_like_escape('foo', '%',     '!', 'assert_like_escape(''foo'',''%'', ''!'')'    );
	CALL assert_like_escape('foo', 'f%',    '!', 'assert_like_escape(''foo'',''f%'', ''!'')'   );
	CALL assert_like_escape('foo', '%o',    '!', 'assert_like_escape(''foo'',''%o'', ''!'')'   );

	CALL assert_like_escape('foo', '!foo',  '!', 'assert_like_escape(''foo'',''!foo'', ''!'')' );
	CALL assert_like_escape('foo', '!fo_',  '!', 'assert_like_escape(''foo'',''!fo_'', ''!'')' );
	CALL assert_like_escape('foo', 'f_!o',  '!', 'assert_like_escape(''foo'',''f_!o'', ''!'')' );
	CALL assert_like_escape('foo', '_!o!o', '!', 'assert_like_escape(''foo'',''_!o!o'', ''!'')');
	CALL assert_like_escape('foo', '_!o_',  '!', 'assert_like_escape(''foo'',''_!o_'', ''!'')' );
	CALL assert_like_escape('foo', '!f%',   '!', 'assert_like_escape(''foo'',''!f%'', ''!'')'  );
	CALL assert_like_escape('foo', '%!o',   '!', 'assert_like_escape(''foo'',''%!o'', ''!'')'  );

	CALL expect_to_fail; CALL assert_like_escape('foo', 'fo!_', '!', 'assert_like_escape(''foo'',''bo!_'', ''!'')' );
	CALL expect_to_fail; CALL assert_like_escape('foo', 'f!_o', '!', 'assert_like_escape(''foo'',''b!_o'', ''!'')' );
	CALL expect_to_fail; CALL assert_like_escape('foo', '!_or', '!', 'assert_like_escape(''foo'',''!_oo'', ''!'')' );
	CALL expect_to_fail; CALL assert_like_escape('foo', '_o!_', '!', 'assert_like_escape(''foo'',''!_o!_'', ''!'')');
	CALL expect_to_fail; CALL assert_like_escape('foo', 'f!%',  '!', 'assert_like_escape(''foo'',''b!%'', ''!'')'  );
	CALL expect_to_fail; CALL assert_like_escape('foo', '!%o',  '!', 'assert_like_escape(''foo'',''!%o'', ''!'')'  );
END //

