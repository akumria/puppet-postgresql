class postgresql::server (
  $server_package = $postgresql::params::server_package,
  $version = $postgresql::params::version,
  $listen = $postgresql::params::listen_address,
  $port = $postgresql::params::port

) inherits postgresql::params {

  package { "postgresql-server-$version":
    name    => sprintf("%s-%s", $server_package, $version),
    ensure  => present,
  }

  service { "postgresql-system-$version":
    name        => 'postgresql',
    enable      => true,
    ensure      => running,
    hasstatus   => false,
    hasrestart  => true,
    provider    => 'debian',
    subscribe   => Package["postgresql-server-$version"],
  }

  file { "postgresql-server-config-$version":
    name    => "/etc/postgresql/$version/main/postgresql.conf",
    ensure  => present,
    content => template('postgresql/postgresql.conf'),
    owner   => 'postgres',
    group   => 'postgres',
    mode    => '0644',
    require => Package["postgresql-server-$version"],
    notify  => Service["postgresql-system-$version"],
  }

}
