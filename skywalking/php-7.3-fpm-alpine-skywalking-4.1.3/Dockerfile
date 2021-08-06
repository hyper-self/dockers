#镜像生成 docker build -t vallbuy/skywalking-php-7.3-fpm-alpine-4.1.3 ./
FROM php:7.3-fpm-alpine

#复制源
COPY ./repositories /etc/apk/repositories

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/usr/local/lib64
ENV LD_RUN_PATH=$LD_RUN_PATH:/usr/local/lib:/usr/local/lib64

ENV SKYWALKING_PHP_TAG 4.1.3

RUN set -ex \
	&& apk add --update --no-cache autoconf g++ protobuf-dev grpc-dev curl-dev make re2c linux-headers libtool \

	&& pecl install protobuf grpc \
	&& docker-php-ext-enable protobuf grpc
	# installing skywalking
	#&& pecl install skywalking \
	#&& docker-php-ext-enable skywalking

RUN set -ex \
	&& curl -Lo v${SKYWALKING_PHP_TAG}.tar.gz https://github.com.cnpmjs.org/SkyAPM/SkyAPM-php-sdk/archive/v${SKYWALKING_PHP_TAG}.tar.gz \
	&& tar zxvf v${SKYWALKING_PHP_TAG}.tar.gz \
	&& cd SkyAPM-php-sdk-${SKYWALKING_PHP_TAG} \
	&& phpize && ./configure --with-grpc=/var/local/git/grpc && make && make install \
	&& cd ../ && rm -rf SkyAPM-php-sdk-${SKYWALKING_PHP_TAG} v${SKYWALKING_PHP_TAG}.tar.gz


COPY ./ext-skywalking.ini $PHP_INI_DIR/conf.d/ext-skywalking.ini
COPY ./docker-entrypoint.sh /opt/

ENTRYPOINT ["/opt/docker-entrypoint.sh"]

EXPOSE 9000

CMD ["php-fpm"]