# == Class: nginx
#
# === Examples
#
#  class { 'nginx':
#    user                      => 'nginx',
#    worker_processes          => 'auto',
#    error_log                 => '/var/log/nginx/error.log',
#    pid                       => '/run/nginx.pid',
#    include                   => [ '/usr/share/nginx/modules/*.conf' ],
#    worker_connections        => '1024',
#    access_log                => '/var/log/nginx/access.log  main',
#    sendfile                  => 'on',
#    tcp_nopush                => 'on',
#    tcp_nodelay               => 'on',
#    keepalive_timeout         => '65',
#    types_hash_max_size       => '2048',
#    default_type              => 'application/octet-stream',
#    http_include              => [ '/etc/nginx/mime.types', '/etc/nginx/conf.d/*.conf', '/etc/nginx/sites-enabled/*.conf' ],
#    server_tokens             => 'off',
#  }
#  
#  class { 'nginx::virtual_server':
#    server_tokens => 'off',
#  }
#
# === Authors
#
# Aneesh C <aneeshchandrasekharan@gmail.com>
#

class nginx (
  $package_name              = [ 'nginx' ],
  $configfile                = '/etc/nginx/nginx.conf',
  $template                  = 'nginx/configfile.erb',
  $user                      = undef,
  $worker_processes          = undef,
  $error_log                 = undef,
  $pid                       = undef,
  $include                   = [],
  $worker_connections        = undef,
  $access_log                = undef,
  $sendfile                  = undef,
  $tcp_nopush                = undef,
  $tcp_nodelay               = undef,
  $keepalive_timeout         = undef,
  $types_hash_max_size       = undef,
  $default_type              = undef,
  $http_include              = [],
  $http_error_log            = undef,
  $gzip                      = undef,
  $gzip_disable              = undef,
  $ssl_protocols             = undef,
  $ssl_prefer_server_ciphers = undef,
  $server_tokens             = undef,
) {
  package { $package_name: ensure => installed }
  file { $configfile:
    require => Package[$package_name],
    backup  => '.backup',
    content => template($template),
  }
  if $::osfamily == 'RedHat' {
    service { 'nginx':
      require => package[$package_name],
      enable  => true,
    }
  }
}
