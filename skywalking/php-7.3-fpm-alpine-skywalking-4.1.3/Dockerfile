#镜像生成 docker build -t vallbuy/skywalking-php-7.3-fpm-alpine-4.1.3 ./
FROM php:7.3-fpm-alpine

#复制源
COPY ./repositories /etc/apk/repositories

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/usr/local/lib64
ENV LD_RUN_PATH=$LD_RUN_PATH:/usr/local/lib:/usr/local/lib64

ENV SKYWALKING_PHP_TAG 4.1.3
ENV GRPC_RELEASE_TAG v1.31.x

RUN set -ex \
	&& apk add --update --no-cache autoconf g++ protobuf-dev grpc-dev curl-dev make re2c linux-headers libtool git\
	&& echo "--- clone grpc ---" \
    && git clone --depth 1 -b ${GRPC_RELEASE_TAG} https://github.com/grpc/grpc /var/local/git/grpc \
    && cd /var/local/git/grpc \
    && git submodule update --init --recursive \
	&& echo "--- installing grpc ---" \
    && cd /var/local/git/grpc \
    && mkdir -p cmake/build && cd cmake/build && cmake -DBUILD_SHARED_LIBS=ON ../.. \
    && make -j$(nproc)

COPY ./ext-skywalking.ini $PHP_INI_DIR/conf.d/ext-skywalking.ini
COPY ./docker-entrypoint.sh /opt/

ENTRYPOINT ["/opt/docker-entrypoint.sh"]

EXPOSE 9000

CMD ["php-fpm"]