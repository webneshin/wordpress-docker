ARG PHP_VER=8.1
FROM wordpress:php${PHP_VER}


ARG PHP_VER

RUN apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y \
  # nano
  nano

# Increase Upload and Memory Limit
RUN echo "file_uploads = On\n" \
         "memory_limit = 128M\n" \
         "upload_max_filesize = 64M\n" \
         "post_max_size = 64M\n" \
         "max_execution_time = 180\n" \
         "max_input_vars = 10000\n" \
         > /usr/local/etc/php/conf.d/custom-limits.ini

# Increase Memory Limit for Wordpress
RUN sed \
	-i "/MySQL settings/idefine( 'WP_MEMORY_LIMIT', '256M' );" \
	/usr/src/wordpress/wp-config-sample.php

## Install ioncube
#RUN curl -fSL 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz' -o /tmp/ioncube_loaders_lin_x86-64.tar.gz
##COPY ioncube_loaders_lin_x86-64.tar.gz /tmp/
#RUN tar xvzfC /tmp/ioncube_loaders_lin_x86-64.tar.gz /tmp/ && \
#	php_ext_dir="$(php -i | grep extension_dir | head -n1 | awk '{print $3}')" && \
#	mv /tmp/ioncube/ioncube_loader_lin_${PHP_VER}.so "${php_ext_dir}/" && \
#    echo "zend_extension = $php_ext_dir/ioncube_loader_lin_${PHP_VER}.so" \
#        > /usr/local/etc/php/conf.d/00-ioncube.ini && \
#	rm /tmp/ioncube_loaders_lin_x86-64.tar.gz && \
#	rm -rf /tmp/ioncube
