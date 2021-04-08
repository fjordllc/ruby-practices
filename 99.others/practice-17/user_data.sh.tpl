#!/bin/bash

set -x
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1

amazon-linux-extras install nginx1 -y

# foo.conf の配置
cat << EOF > /etc/nginx/conf.d/foo.conf
server {
    listen       80;
    server_name  foo.${TARGET_DOMAIN};

    location / {
        root   /usr/share/nginx/foo;
        index  index.html index.htm;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/foo;
    }

    access_log  /var/log/nginx/foo.access.log  main;
    error_log  /var/log/nginx/foo.error.log warn;
}

server {
    listen       443;
    server_name  foo.${TARGET_DOMAIN};

    ssl                  on;
    ssl_certificate      /etc/nginx/server.crt;
    ssl_certificate_key  /etc/nginx/server.key;

    ssl_protocols        TLSv1.3 TLSv1.2 TLSv1.1;
    ssl_ciphers          HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers   on;

    location / {
        root   /usr/share/nginx/foo;
        index  index.html index.htm;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/foo;
    }

    access_log  /var/log/nginx/foo.access.log  main;
    error_log  /var/log/nginx/foo.error.log warn;
}
EOF

# bar.conf の配置
cat << EOF > /etc/nginx/conf.d/bar.conf
server {
    listen       80;
    server_name  bar.${TARGET_DOMAIN};

    location / {
        root   /usr/share/nginx/bar;
        index  index.html index.htm;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/bar;
    }

    access_log  /var/log/nginx/bar.access.log  main;
    error_log  /var/log/nginx/bar.error.log warn;
}

server {
    listen       443;
    server_name  bar.${TARGET_DOMAIN};

    ssl                  on;
    ssl_certificate      /etc/nginx/server.crt;
    ssl_certificate_key  /etc/nginx/server.key;

    ssl_protocols        TLSv1.3 TLSv1.2 TLSv1.1;
    ssl_ciphers          HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers   on;

    location / {
        root   /usr/share/nginx/bar;
        index  index.html index.htm;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/bar;
    }

    access_log  /var/log/nginx/bar.access.log  main;
    error_log  /var/log/nginx/bar.error.log warn;
}
EOF

# 既存の設定をコピー
cp -a /usr/share/nginx/html /usr/share/nginx/foo
cp -a /usr/share/nginx/html /usr/share/nginx/bar

# foo 用の HTML 配置
cat << EOF > /usr/share/nginx/foo/index.html
<!DOCTYPE html>
<html>
    <head>
        <title>Foo</title>
    </head>
    <body>
        <p>Foo Page</p>
    </body>
</html>
EOF

# bar 用の HTML 配置
cat << EOF > /usr/share/nginx/bar/index.html
<!DOCTYPE html>
<html>
    <head>
        <title>Bar</title>
    </head>
    <body>
        <p>Bar Page</p>
    </body>
</html>
EOF

openssl genrsa 2048 > /etc/nginx/server.key
openssl req -new -subj "/C=JP/ST=Test/L=Test/O=Test/OU=Test/CN=*.${TARGET_DOMAIN}" -key /etc/nginx/server.key > /etc/nginx/server.csr
openssl x509 -days 365 -req -signkey /etc/nginx/server.key < /etc/nginx/server.csr > /etc/nginx/server.crt

service nginx start
