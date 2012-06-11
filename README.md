Puppet module for postgresql
============================

Basic usage
-----------

To install the client software

    class {'postgresql':  }

To specify a particular version

    class {'postgresql':
        version => '9.1',
    }

To install the server

	class {'postgresql::server': }

Again, a particular version

	class {'postgresql::server':
		version => '9.1',
	}

Listen on a specific post / IP address

	class {'postgresql::server':
		listen => ['192.168.0.1', ],
		port   => 5432
	}

Create a user
-------------

Actually this creates a role in the database cluster

	class postgresql::user { 'pguser':
		superuser => false,
		password  => 'pgpassword',
	}


Create a database
-----------------

	class postgresql::db { 'pgdb':
		owner    => 'pguser',
		encoding => 'UTF-8',
	}


Contributors
------------

 * [Anand Kumria](https://github.com/akumria) ([@akumria](https://twitter.com/akumria))


Copyright and License
---------------------

Copyright 2012 [Linuxpeak](https://www.linuxpeak.com/) Pty Ltd.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
