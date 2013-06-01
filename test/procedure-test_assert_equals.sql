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

DROP PROCEDURE IF EXISTS test_assert_equals //

CREATE PROCEDURE test_assert_equals()
	COMMENT 'Test: assert_equals()'
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
BEGIN
	CALL assert_equals(TRUE,  TRUE,  'assert_equals(TRUE, TRUE)'  );
	CALL assert_equals(TRUE,  1,     'assert_equals(TRUE, 1)'     );
	CALL assert_equals(TRUE,  '1',   'assert_equals(TRUE, ''1'')' );
	CALL assert_equals(1,     TRUE,  'assert_equals(1, TRUE)'     );
	CALL assert_equals(1,     1,     'assert_equals(1, 1)'        );
	CALL assert_equals(1,     '1',   'assert_equals(1, ''1'')'    );
	CALL assert_equals('1',   TRUE,  'assert_equals(''1'', TRUE)' );
	CALL assert_equals('1',   1,     'assert_equals(''1'', 1)'    );
	CALL assert_equals('1',   '1',   'assert_equals(''1'', ''1'')');

	CALL assert_equals(FALSE, FALSE, 'assert_equals(FALSE, FALSE)');
	CALL assert_equals(FALSE, 0,     'assert_equals(FALSE, 0)'    );
	CALL assert_equals(FALSE, '0',   'assert_equals(FALSE, ''0'')');
	CALL assert_equals(0,     FALSE, 'assert_equals(0, FALSE)'    );
	CALL assert_equals(0,     0,     'assert_equals(0, 0)'        );
	CALL assert_equals(0,     '0',   'assert_equals(0, ''0'')'    );
	CALL assert_equals('0',   FALSE, 'assert_equals(''0'', FALSE)');
	CALL assert_equals('0',   0,     'assert_equals(''0'', 0)'    );
	CALL assert_equals('0',   '0',   'assert_equals(''0'', ''0'')');

	CALL assert_equals(NULL,  NULL,  'assert_equals(NULL, NULL)'  );

	CALL expect_to_fail(); CALL assert_equals(FALSE, TRUE,  'assert_equals(FALSE, TRUE)' );
	CALL expect_to_fail(); CALL assert_equals(FALSE, 1,     'assert_equals(FALSE, 1)'    );
	CALL expect_to_fail(); CALL assert_equals(FALSE, '1',   'assert_equals(FALSE, ''1'')');
	CALL expect_to_fail(); CALL assert_equals(0,     TRUE,  'assert_equals(0, TRUE)'     );
	CALL expect_to_fail(); CALL assert_equals(0,     1,     'assert_equals(0, 1)'        );
	CALL expect_to_fail(); CALL assert_equals(0,     '1',   'assert_equals(0, ''1'')'    );
	CALL expect_to_fail(); CALL assert_equals('0',   TRUE,  'assert_equals(''0'', TRUE)' );
	CALL expect_to_fail(); CALL assert_equals('0',   1,     'assert_equals(''0'', 1)'    );
	CALL expect_to_fail(); CALL assert_equals('0',   '1',   'assert_equals(''0'', ''1'')');

	CALL expect_to_fail(); CALL assert_equals(TRUE,  FALSE, 'assert_equals(TRUE, FALSE)' );
	CALL expect_to_fail(); CALL assert_equals(TRUE,  0,     'assert_equals(TRUE, 0)'     );
	CALL expect_to_fail(); CALL assert_equals(TRUE,  '0',   'assert_equals(TRUE, ''0'')' );
	CALL expect_to_fail(); CALL assert_equals(1,     FALSE, 'assert_equals(1, FALSE)'    );
	CALL expect_to_fail(); CALL assert_equals(1,     0,     'assert_equals(1, 0)'        );
	CALL expect_to_fail(); CALL assert_equals(1,     '0',   'assert_equals(1, ''0'')'    );
	CALL expect_to_fail(); CALL assert_equals('1',   FALSE, 'assert_equals(''1'', FALSE)');
	CALL expect_to_fail(); CALL assert_equals('1',   0,     'assert_equals(''1'', 0)'    );
	CALL expect_to_fail(); CALL assert_equals('1',   '0',   'assert_equals(''1'', ''0'')');

	CALL expect_to_fail(); CALL assert_equals(NULL,  FALSE, 'assert_equals(NULL, FALSE)' );
	CALL expect_to_fail(); CALL assert_equals(NULL,  TRUE,  'assert_equals(NULL, TRUE)'  );
	CALL expect_to_fail(); CALL assert_equals(NULL,  0,     'assert_equals(NULL, 0)'     );
	CALL expect_to_fail(); CALL assert_equals(NULL,  1,     'assert_equals(NULL, 1)'     );
	CALL expect_to_fail(); CALL assert_equals(FALSE, NULL,  'assert_equals(FALSE, NULL)' );
	CALL expect_to_fail(); CALL assert_equals(TRUE,  NULL,  'assert_equals(TRUE, NULL)'  );
	CALL expect_to_fail(); CALL assert_equals(0,     NULL,  'assert_equals(0, NULL)'     );
	CALL expect_to_fail(); CALL assert_equals(1,     NULL,  'assert_equals(1, NULL)'     );
END //

