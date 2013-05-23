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

DELIMITER //

SET SESSION
	autocommit               := TRUE,
	character_set_client     := utf8mb4,
	character_set_results    := utf8mb4,
	character_set_connection := utf8mb4,
	collation_connection     := utf8mb4_general_ci,
	foreign_key_checks       := TRUE,
	innodb_strict_mode       := ON,
	sql_mode                 := 'TRADITIONAL,NO_AUTO_VALUE_ON_ZERO',
	sql_notes                := TRUE,
	sql_warnings             := TRUE,
	unique_checks            := TRUE //

CREATE DATABASE IF NOT EXISTS fab_unit COLLATE utf8mb4_general_ci //

USE fab_unit //

