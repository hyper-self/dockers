#镜像生成 docker build -t vallbuy/skywalking-php-7.3-fpm-alpine ./
FROM php:7.3-fpm-alpine

#复制源
COPY ./repositories /etc/apk/repositories

RUN set -ex \
	&& apk add --update --no-cache autoconf g++ protobuf-dev grpc-dev curl-dev make re2c

    # installing skywalking
	#&& pecl install skywalking \
	#&& docker-php-ext-enable skywalking

RUN set -ex \
	&& curl -Lo v4.1.1.tar.gz https://github.com.cnpmjs.org/SkyAPM/SkyAPM-php-sdk/archive/v4.1.1.tar.gz \
	&& tar zxvf v4.1.1.tar.gz \
	&& cd SkyAPM-php-sdk-4.1.1 \
	&& phpize && ./configure && make && make install \
	&& cd ../ && rm -rf SkyAPM-php-sdk-4.1.1 v4.1.1.tar.gz


COPY ./ext-skywalking.ini $PHP_INI_DIR/conf.d/ext-skywalking.ini
COPY ./docker-entrypoint.sh /opt/

ENTRYPOINT ["/opt/docker-entrypoint.sh"]

CMD ["php-fpm"]