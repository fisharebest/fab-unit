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

CREATE OR REPLACE VIEW reserved_word_view AS
SELECT schema_name, 'Schema' AS object_type, schema_name AS object_name
FROM information_schema.schemata
JOIN fab_unit.reserved_word ON (schema_name = reserved_word)
UNION
SELECT table_schema, 'Table', CONCAT(table_schema, '.', table_name)
FROM information_schema.tables
JOIN fab_unit.reserved_word ON (table_name = reserved_word)
UNION
SELECT table_schema, 'Column', CONCAT(table_schema, '.', table_name, '.', column_name)
FROM information_schema.columns
JOIN fab_unit.reserved_word ON (column_name = reserved_word)
//
