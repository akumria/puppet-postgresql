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

To create a database owned by a user

    postgresql::db { 'myuser':
        password => 'mypassword',
    }

This will create `myuser` and then create a database called `myuser`
which will owned by `myuser`. You can override the default locale and
encoding and, if required, specify a different owner. For example:

    postgresql::db { 'mydatabase':
        owner    => 'myuser',
        password => 'mypassword',
        locale   => 'en_AU.UTF-8',
        encoding => 'C',
    }


Read on, if your specific setup does not fall within this (admittedly simple) framework.

Create a user
-------------

Actually this creates a role in the database cluster

	pg_user {'pguser':
		ensure   => present,
		password => 'pgpassword',
	}


Create a database
-----------------

This creates a database and adds in a dependancy relationship to the user

	pg_database {'pgdb':
		ensure   => present,
		owner    => 'pguser',
		require  => Pg_user['pguser'],
	}

You can also specify both the locale and encoding of a database. The default, for English, should be fine though.

	pg_database {'pgdb':
		ensure   => present,
		owner    => 'pguser',
		encoding => 'UTF8',
		locale   => 'de_DE.UTF-8',
		require  => Pg_user['pguser'],
	}



Contributors
------------

 * [Anand Kumria](https://github.com/akumria) ([@akumria](https://twitter.com/akumria))
 * [Federico Maggi](https://github.com/phretor)


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
