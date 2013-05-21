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

DROP PROCEDURE IF EXISTS run //

CREATE PROCEDURE run (
	p_schema_name TEXT
)
	COMMENT 'Run the unit tests for current database'
	LANGUAGE SQL
	DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY DEFINER
BEGIN
	-- The function DATABASE() is evaulated when the procedure is
	-- compiled, meaning that it refers to the fab_unit schema,
	-- not the one we are testing.  Hence capture it early.
	SET @_fab_schema_name := p_schema_name;

	CALL fab_unit.reserved_words(@_fab_schema_name);
END //
