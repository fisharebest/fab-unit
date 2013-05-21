# fab-unit - A unit test framework for MySQL applications
#
# Copyright (c) 2013 Greg Roach, fisharebest@gmail.com
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

fab-unit.sql: src/connection.sql src/procedure-*.sql src/table-*.sql
	cat $^ > $@

clean:
	rm -f fab-unit.sql

self-test: clean fab-unit.sql
	mysql                     --execute "SOURCE fab-unit.sql"
	mysql --database fab_unit --execute "CALL fab_unit.run(DATABASE())"
