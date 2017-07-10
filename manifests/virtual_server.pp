define nginx::virtual_server (
  $package_name         = $::nginx::package_name,
  $virtualhostdir       = '/etc/nginx/sites-available',
  $template             = 'nginx/virtual_server.erb',
  $file_name            = undef,
  $listen               = [],
  $root                 = undef,
  $index                = undef,
  $upstream             = [],
  $server_tokens        = undef,
  $server_name          = undef,
  $access_log           = undef,
  $error_log            = undef,
  $return               = undef,
  $ssl                  = undef,
  $ssl_certificate      = undef,
  $ssl_certificate_key  = undef,
  $location             = [],
  $error_page           = [],
  $client_max_body_size = undef,
  $include              = [],
) {
  if ! defined(File['/etc/nginx/sites-available']) {
    file { '/etc/nginx/sites-available':
      ensure  => directory,
      require => Package[$package_name],
    }
    file { '/etc/nginx/sites-enabled':
      ensure  => directory,
      require => Package[$package_name],
    }
  }
  file { "${virtualhostdir}/${file_name}":
    require => Package[$package_name],
    backup  => '.backup',
    content => template($template),
  }
}
