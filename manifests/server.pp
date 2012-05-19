class postgresql::server (
  $server_package = $postgresql::params::server_package,
  $version = $postgresql::params::version

) inherits postgresql::params {

  package { "postgresql-server-$version":
    name   => "$server_package-$version",
    ensure => present,
  }

}
