FROM debian:jessie

MAINTAINER Silvio Fricke <silvio.fricke@gmail.com>

ENV VERSION 3.7
ADD https://www.languagetool.org/download/LanguageTool-$VERSION.zip /LanguageTool-$VERSION.zip

RUN set -ex \
    && mkdir -p /uploads /etc/apt/sources.list.d \
    && echo "deb http://ftp.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie.backports.list \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get clean \
    && apt-get update -y \
    && apt-get -t jessie-backports install -y \
	openjdk-8-jre-headless \
	unzip \
    && unzip LanguageTool-$VERSION.zip \
    && rm LanguageTool-$VERSION.zip

WORKDIR /LanguageTool-$VERSION

CMD ["java", "-cp", "languagetool-server.jar", "org.languagetool.server.HTTPServer", "--port", "8010", "--public" ]
EXPOSE 8010
