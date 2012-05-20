class postgresql::server (
  $server_package = $postgresql::params::server_package,
  $version = $postgresql::params::version,
  $listen = $postgresql::params::listen_address,
  $port = $postgresql::params::port

) inherits postgresql::params {

  package { "postgresql-server-$version":
    name   => "$server_package-$version",
    ensure => present,
  }

}
