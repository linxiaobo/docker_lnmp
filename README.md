# Introduction

Deploy lnmp(Linux, Nginx, MySQL, PHP7) using docker.

I want to share my ideas and designs about Web-Deploying using Docker with you.

### Architecture

![architecture][1]

Note: The local ports may differ.

The whole app is divided into three Containers:

1. Nginx is running in `Nginx` Container, which handles requests and makes responses.
2. PHP or PHP-FPM is put in `PHP-FPM` Container, it retrieves php scripts from host, interprets, executes then responses to Nginx. If necessary, it will connect to `MySQL` as well.
3. MySQL lies in `MySQL` Container,

Our app scripts are located on host, you can edit files directly without rebuilding/restarting whole images/containers.

### Build and Run

At first, you should have had [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose) installed.

Without building images one by one, you can make use of `docker-compose` and simply issue:

    $ docker-compose up -d

Check out your https://\<docker-host\> and have fun :beer:

### Contributors

Based in https://github.com/micooz/docker-lnmp

### License

MIT

  [1]: docker/docs/architecture.png
  
### Trouble Shooting
#### On Ubuntu18.04, mailcatcher might have install problem:

+ apk update
fetch http://mirror.yandex.ru/mirrors/alpine/v3.5/main/x86_64/APKINDEX.tar.gz
ERROR: http://mirror.yandex.ru/mirrors/alpine/v3.5/main: temporary error (try again later)
WARNING: Ignoring APKINDEX.3033a77c.tar.gz: No such file or directory
fetch http://mirror.yandex.ru/mirrors/alpine/v3.5/community/x86_64/APKINDEX.tar.gz
ERROR: http://mirror.yandex.ru/mirrors/alpine/v3.5/community: temporary error (try again later)
WARNING: Ignoring APKINDEX.073ff569.tar.gz: No such file or directory
fetch http://dl-cdn.alpinelinux.org/alpine/x86_64/APKINDEX.tar.gz
ERROR: http://dl-cdn.alpinelinux.org/alpine: temporary error (try again later)
WARNING: Ignoring APKINDEX.8cf3a56b.tar.gz: No such file or directory
3 errors; 30 distinct packages available
ERROR: Service 'mailcatcher' failed to build: The command '/bin/sh -c set -xe     && apk update     && apk add --no-cache         libstdc++         sqlite-libs     && apk add --no-cache --virtual .build-deps         build-base         sqlite-dev     && gem install mailcatcher -v 0.6.5 --no-ri --no-rdoc     && apk del .build-deps' returned a non-zero code: 3


#### The solution is:

Ubuntu 18.04 changed to use systemd-resolved to generate /etc/resolv.conf. Now by default it uses a local DNS cache 127.0.0.53. That will not work inside a container, so Docker will default to Google's 8.8.8.8 DNS server, which may break for people behind a firewall.

/etc/resolv.conf is actually a symlink (ls -l /etc/resolv.conf) which points to /run/systemd/resolve/stub-resolv.conf (127.0.0.53) by default in Ubuntu 18.04.

Just change the symlink to point to /run/systemd/resolve/resolv.conf, which lists the real DNS servers:

    $ sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf

Verify on the host: cat /etc/resolv.conf
