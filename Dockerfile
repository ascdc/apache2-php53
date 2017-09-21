FROM ubuntu:trusty
MAINTAINER ASCDC <asdc.sinica@gmail.com>

ADD run.sh /run.sh

RUN DEBIAN_FRONTEND=noninteractive && \
	chmod +x /run.sh && \
	apt-get -qq update && \
	apt-get -y -qq dist-upgrade && \
	locale-gen en_US.UTF-8 && \
	export LANG=en_US.UTF-8
RUN DEBIAN_FRONTEND=noninteractive && apt-get -qq install -y vim screen wget git curl re2c autoconf build-essential libxml2-dev wget libbz2-dev libjpeg-turbo8-dev libpng-dev libmcrypt-dev libmysqlclient-dev libpq-dev libicu-dev libfreetype6-dev libldap2-dev libxslt-dev pkg-config libsslcommon2-dev libssl-dev libc-client-dev libkrb5-dev libldb-dev libpspell-dev libxpm-dev librecode-dev libtidy-dev libgmp-dev libltdl-dev libreadline6-dev apache2 apache2-dev libcurl4-openssl-dev
RUN DEBIAN_FRONTEND=noninteractive && cd /tmp && \
	wget -q http://in1.php.net/distributions/php-5.3.29.tar.bz2 && \
	tar -xf php-5.3.29.tar.bz2 && \
	cd /tmp/php-5.3.29 && \
	ln -sf /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h && \
	ln -sf /usr/lib/x86_64-linux-gnu/libXpm.so /usr/lib/ && \
	ln -sf /usr/lib/x86_64-linux-gnu/libXpm.a /usr/lib/ && \
	ln -sf /usr/lib/x86_64-linux-gnu/libfreetype.so /usr/lib/ && \
	ln -sf /usr/lib/x86_64-linux-gnu/libfreetype.a /usr/lib/ && \
	ln -sf /usr/lib/x86_64-linux-gnu/libldap.a /usr/lib/ && \
	ln -sf /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/ && \
	mkdir /etc/php && \
	mkdir /etc/php/conf.d && \
	cp ./php.ini-production /etc/php/php.ini && \
	sed -i "s/short_open_tag = .*/short_open_tag = On/g" /etc/php/php.ini && \
	sed -i "s/max_execution_time = .*/max_execution_time = 300/g" /etc/php/php.ini && \
	sed -i "s/max_input_time = .*/max_input_time = 300/g" /etc/php/php.ini && \
	sed -i "s/memory_limit = .*/memory_limit = 1024M/g" /etc/php/php.ini && \
	sed -i "s/post_max_size = .*/post_max_size = 200M/g" /etc/php/php.ini && \
	sed -i "s/upload_max_filesize = .*/upload_max_filesize = 200M/g" /etc/php/php.ini && \
	sed -i "s/;date.timezone.*/date.timezone = \"Asia\/Taipei\"/g" /etc/php/php.ini && \
	./configure --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=x86_64-linux-gnu --program-prefix= --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/usr/com --mandir=/usr/share/man --infodir=/usr/share/info --cache-file=../config.cache --with-libdir=lib --with-config-file-path=/etc/php --with-config-file-scan-dir=/etc/php/conf.d --disable-debug --with-pic --enable-rpath --without-pear --with-bz2 --with-exec-dir=/usr/bin --with-png-dir=/usr --with-xpm-dir=/usr --enable-gd-native-ttf --without-gdbm --with-gettext --with-gmp --with-iconv --with-jpeg-dir=/usr --with-openssl --with-zlib --with-layout=GNU --enable-exif --enable-ftp --enable-magic-quotes --enable-sockets --enable-sysvsem --enable-sysvshm --enable-sysvmsg --with-kerberos --enable-ucd-snmp-hack --enable-shmop --enable-calendar --with-libxml-dir=/usr --enable-xml --with-apxs2=/usr/bin/apxs --with-mysql --with-gd --enable-dom --disable-dba --without-unixODBC --enable-pdo --enable-xmlreader --enable-xmlwriter --with-sqlite3 --enable-phar --enable-fileinfo --enable-json --with-ldap  --without-pspell --enable-wddx --with-curl --enable-posix --disable-sysvmsg --disable-sysvshm --disable-sysvsem --enable-mbstring --with-mcrypt --with-pgsql  --enable-embedded-mysqli --enable-zip --with-bz2 --with-xmlrpc --enable-soap --with-xsl --enable-maintainer-zts && \
	sed -i "s/EXTRA_LIBS = \(.*\)/EXTRA_LIBS = \1 -llber/g" ./Makefile && \
	make && \
	make install && \
	rm -rf /tmp/*
RUN DEBIAN_FRONTEND=noninteractive && \
	ln -sf ../mods-available/authn_anon.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/authn_dbm.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/authz_owner.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/authz_groupfile.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/authz_dbm.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/include.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/ext_filter.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/mime_magic.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/mime_magic.conf /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/expires.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/headers.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/usertrack.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/dav.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/info.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/info.conf /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/dav_fs.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/dav_fs.conf /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/vhost_alias.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/actions.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/actions.conf /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/speling.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/userdir.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/userdir.conf /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/rewrite.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/proxy.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/proxy.conf /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/proxy_balancer.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/proxy_balancer.conf /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/proxy_ftp.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/proxy_ftp.conf /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/proxy_http.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/proxy_connect.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/cache.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/suexec.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/cgi.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/proxy_ajp.load /etc/apache2/mods-enabled/ && \
	ln -sf ../mods-available/slotmem_shm.load /etc/apache2/mods-enabled/ && \
	echo "AddHandler application/x-httpd-php .php" >> /etc/apache2/apache2.conf && \
	echo "AddType application/x-httpd-php .php .html" >> /etc/apache2/apache2.conf && \
	echo "SetEnv TZ Asia/Taipei" >> /etc/apache2/apache2.conf && \
	echo "ServerName 0.0.0.0" >> /etc/apache2/apache2.conf && \
	echo "<Directory \"/var/www/html\">" >> /etc/apache2/sites-enabled/000-default.conf && \
	echo "Options FollowSymLinks MultiViews" >> /etc/apache2/sites-enabled/000-default.conf && \
	echo "AllowOverride All" >> /etc/apache2/sites-enabled/000-default.conf && \
	echo "Order allow,deny" >> /etc/apache2/sites-enabled/000-default.conf && \
	echo "Allow from all" >> /etc/apache2/sites-enabled/000-default.conf && \
	echo "Require all granted" >> /etc/apache2/sites-enabled/000-default.conf && \
	echo "</Directory>" >> /etc/apache2/sites-enabled/000-default.conf

ENV SERVER_NAME **None**

EXPOSE 80
WORKDIR /var/www/html
ENTRYPOINT ["/run.sh"]
