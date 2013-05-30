# == Class postgresql::params
#
class postgresql::params {
  $locale        = 'en_US.UTF-8'
  $ssl           = false
  $ssl_ca_file   = undef  # the default is 'root.crt'
  $ssl_cert_file = undef  # the default is 'server.crt'
  $ssl_crl_file  = undef  # the default is 'root.crl'
  $ssl_key_file  = undef  # the default is 'server.key'

  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $client_package = 'postgresql-client'
      $server_package = 'postgresql'
      $listen_address = 'localhost'
      $port = 5432

      $version = $::lsbdistcodename ? {
        'squeeze' => '8.4',
        default   => '9.1',
      }

      $service_name = $::lsbdistcodename ? {
        'wheezy' => 'postgresql',
        default  => "postgresql-system-${version}",
      }
    }

    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
}

