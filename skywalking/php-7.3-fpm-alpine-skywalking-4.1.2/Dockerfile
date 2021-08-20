#镜像生成 docker build -t vallbuy/skywalking-php-7.3-fpm-alpine-4.1.2 ./
FROM php:7.3-fpm-alpine

#复制源
COPY ./repositories /etc/apk/repositories

ENV SKYWALKING_PHP_TAG 4.1.2

RUN set -ex \
	&& apk add --update --no-cache autoconf g++ protobuf-dev grpc-dev curl-dev make re2c boost-dev \
	# installing skywalking
	#&& pecl install skywalking \
	#&& docker-php-ext-enable skywalking
	&& docker-php-ext-install mysqli

RUN set -ex \
	&& curl -Lo v${SKYWALKING_PHP_TAG}.tar.gz https://github.com.cnpmjs.org/SkyAPM/SkyAPM-php-sdk/archive/v${SKYWALKING_PHP_TAG}.tar.gz \
	&& tar zxvf v${SKYWALKING_PHP_TAG}.tar.gz \
	&& cd SkyAPM-php-sdk-${SKYWALKING_PHP_TAG} \
	&& phpize && ./configure && make && make install \
	&& cd ../ && rm -rf SkyAPM-php-sdk-${SKYWALKING_PHP_TAG} v${SKYWALKING_PHP_TAG}.tar.gz

COPY ./docker-php-ext-skywalking.ini $PHP_INI_DIR/conf.d/docker-php-ext-skywalking.ini
COPY ./docker-entrypoint.sh /opt/

ENTRYPOINT ["/opt/docker-entrypoint.sh"]

CMD ["php-fpm"]