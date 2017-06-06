# NGINX Module

## Overview

This module install and configure nginx web server.

## Usage

Default configuration:

```puppet
include nginx
```

Change configuration file settings:

```puppet
class { 'nginx':
    user                      => 'nginx',
    worker_processes          => 'auto',
    error_log                 => '/var/log/nginx/error.log',
    pid                       => '/run/nginx.pid',
    include                   => [ '/usr/share/nginx/modules/*.conf' ],
    worker_connections        => '1024',
    access_log                => '/var/log/nginx/access.log  main',
    sendfile                  => 'on',
    tcp_nopush                => 'on',
    tcp_nodelay               => 'on',
    keepalive_timeout         => '65',
    types_hash_max_size       => '2048',
    default_type              => 'application/octet-stream',
    http_include              => [ '/etc/nginx/mime.types', '/etc/nginx/conf.d/*.conf', '/etc/nginx/sites-enabled/*.conf' ],
    server_tokens             => 'off',
}
```

Create virtual server:

```puppet
nginx::virtual_server { 'example.com.conf':
    file_name            => 'example.com.conf',
    listen               => [ '80' ],
    server_name          => 'example.com www.example.com',
    server_tokens        => 'off',
    access_log           => '/var/log/nginx/example.com-access.log',
    error_log            => '/var/log/nginx/example.com-error.log',
    error_page           => [ '404  /404.html', '500 502 503 504  /50x.html' ],
    client_max_body_size => '2M',
    location             => {
        '/'             => [
            'root  /var/www/example.com/public_html/',
            'index index.php  index.html index.htm',
        ],
        '~ \.php$'      => [
            'root          /var/www/example.com/public_html/',
            'fastcgi_pass  127.0.0.1:9000',
            'fastcgi_index index.php',
            'fastcgi_param SCRIPT_FILENAME   $document_root$fastcgi_script_name',
            'include       fastcgi_params',
        ],
        '= /404.html'   => [
            'root /usr/share/nginx/html',
        ],
        '= /50x.html'   => [
            'root /usr/share/nginx/html',
        ],
    },
}
```

