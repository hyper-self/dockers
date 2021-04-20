#镜像生成 docker build -t vallbuy/skywalking-php-7.3-fpm-alpine ./
FROM php:7.3-fpm-alpine

#复制源
COPY ./repositories /etc/apk/repositories

RUN set -ex \
	&& apk add --update --no-cache autoconf g++ protobuf-dev grpc-dev curl-dev make re2c git

    # installing skywalking
	#&& pecl install skywalking \
	#&& docker-php-ext-enable skywalking

RUN set -ex \
	&& git clone https://github.com.cnpmjs.org/SkyAPM/SkyAPM-php-sdk.git \
	&& cd SkyAPM-php-sdk \
	&& phpize && ./configure && make && make install \
	&& cd ../ && rm -rf SkyAPM-php-sdk

COPY ./ext-skywalking.ini $PHP_INI_DIR/conf.d/ext-skywalking.ini
COPY ./docker-entrypoint.sh /opt/

ENTRYPOINT ["/opt/docker-entrypoint.sh"]

EXPOSE 9000

CMD ["php-fpm"]