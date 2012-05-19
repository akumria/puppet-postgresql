class postgresql::params {
  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $version = '9.1'
      $client_package = 'postgresql-client'
      $server_package = 'postgresql'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
}
