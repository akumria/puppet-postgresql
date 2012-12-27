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

By default, the system-wide locale is assumed to be en_US.UTF-8. If the
locale is not installed or available, you can specify an alternative:

    class { 'postgresql::server':
        locale => 'es_ES.UTF-8',
    }

Again, a particular version

	class {'postgresql::server':
		version => '9.1',
	}

Listen on a specific post / IP address

	class {'postgresql::server':
		listen => ['192.168.0.1', ],
		port   => 5432,
	}

To allow a remote host to connect to the server, now that you are listening
on the Internet.

    class {'postgresql::server':
        listen => ['192.168.0.1', ],
        port   => 5432,
        acl    => ['host all all 192.168.0.2/32 md5', ],
    }

Refer to the [pg_hba.conf docs](http://www.postgresql.org/docs/devel/static/auth-pg-hba-conf.html) for
the specifics of what each possible ACL field can be set to. In some situations you made need to insert
the ACL in front of any existing one. The variable `preacl` exists for this purpose.

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

A common scenario is installing PostGIS, and then having a database created with those features enabled.
Postgresql does this with the concept of database templates. By default `template0` is used as that
allows us to override the locale and encoding if required. To create a database from a different template:

    postgresql::db { 'mynextdb':
        owner    => 'anotheruser',
        password => 'anotherpass',
        template => 'template_postgis',
    }

Read on, if your specific setup does not fall within this
 (admittedly simple) framework.

Create a user
-------------

This creates a role in the database cluster, by default the user
is able to login and will inherit the permissions of any groups it
is a member of.

	pg_user {'pguser':
		ensure   => present,
		password => 'pgpassword',
	}

To create users without passwords (such as for peer/ident authentication),
simply leave off the 'password' key.

You can also modify other attributes like whether the user can create
databases (`createdb`), create other roles (`createrole`) or is the
superuser (`superuser`).

For example:

    pg_user {'mighty_pguser':
        ensure     => present,
        password   => 'themightyone',
        createdb   => true,
        createrole => true,
    }


Create a database
-----------------

This creates a database and adds a dependancy relationship to the user

	pg_database {'pgdb':
		ensure   => present,
		owner    => 'pguser',
		require  => Pg_user['pguser'],
	}

The default is `UTF-8` and `en_US.UTF-8` for English. If required,
you can also specify both the locale and encoding of a database.

As well, you can specify the [base template](http://www.postgresql.org/docs/devel/static/manage-ag-templatedbs.html)

	pg_database {'pgdb':
		ensure   => present,
		owner    => 'pguser',
		encoding => 'UTF8',
		locale   => 'de_DE.UTF-8',
		require  => Pg_user['pguser'],
		template => 'template1',
	}

SSL Notes
---------

SSL support is disabled by default. If you enable it, ensure that you have the appropriate
server and root certificates, keys and revocations files already in place otherwise Postgresql
will not start.

Additionally note that only Postgresql 9.2 (and later) allow you to configure the [SSL files](http://www.postgresql.org/docs/9.2/static/ssl-tcp.html)
that the server will look for. [Prior versions](http://www.postgresql.org/docs/9.1/static/ssl-tcp.html) have hardcoded defaults.

Notes
-----

This module will not (yet) update either the user or database once they have
been initially created. i.e. changing the `login` permission of a user does not work.
Nor does changing the locale of an existing database.

With Puppet version less than 3.0, you must [enable pluginsync](http://docs.puppetlabs.com/guides/plugins_in_modules.html#enabling-pluginsync),
so that the custom types are sent to each client.


Contributors
------------

 * [Anand Kumria](https://github.com/akumria) ([@akumria](https://twitter.com/akumria))
 * [Federico Maggi](https://github.com/phretor)
 * [Joe Topjian](https://github.com/jtopjian)
 * [Stephan Hochdörfer](https://github.com/shochdoerfer)
 * [Marcello Barnaba](https://github.com/vjt)
 * [Ramón Cahenzli](https://github.com/psy-q)
 * [Bert Hajee](https://github.com/hajee)
 * [Patrick Hemmer](https://github.com/phemmer)
 * [Marcello Barnaba](https://github.com/vjt)

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
