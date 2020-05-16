FROM debian:stretch

MAINTAINER Silvio Fricke <silvio.fricke@gmail.com>

RUN set -ex \
    && mkdir -p /uploads /etc/apt/sources.list.d /var/cache/apt/archives/ \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get clean \
    && apt-get update -y \
    && apt-get install -y \
        bash \
        openjdk-8-jre-headless \
        unzip

ADD misc/entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
RUN mkdir /nonexistent && touch /nonexistent/.languagetool.cfg

ENTRYPOINT ["/entrypoint.sh"]
