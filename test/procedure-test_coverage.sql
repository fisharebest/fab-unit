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

DROP PROCEDURE IF EXISTS test_coverage //

CREATE PROCEDURE test_coverage()
	COMMENT 'Self-test: test_coverage()'
	LANGUAGE SQL
	NOT DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	DECLARE l_routine TEXT;

	DECLARE c_coverage CURSOR FOR
	SELECT r1.routine_name
	FROM       information_schema.routines r1
	LEFT JOIN  information_schema.routines r2 ON (r1.routine_schema=r2.routine_schema AND r2.routine_name = CONCAT('test_', r1.routine_name))
	WHERE  r1.routine_schema = DATABASE()
	AND    r1.routine_name LIKE 'assert_%'
	AND    r2.routine_name IS NULL;

	OPEN c_coverage;
	BEGIN
		DECLARE EXIT HANDLER FOR NOT FOUND CLOSE c_coverage;
		LOOP
			FETCH c_coverage INTO l_routine;
			CALL assert(FALSE, CONCAT('No test script for ', l_routine, '()'));
		END LOOP;
	END;

	IF l_routine IS NULL THEN
		CALL assert(TRUE, 'All assertions have test scripts');
	END IF;
END //
