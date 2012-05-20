class postgresql::params {
  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $version = '9.1'
      $client_package = 'postgresql-client'
      $server_package = 'postgresql'
      $listen_address = 'localhost'
      $port = 5432
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
}
