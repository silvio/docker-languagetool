FROM debian:jessie

MAINTAINER Silvio Fricke <silvio.fricke@gmail.com>

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
	openjdk-7-jre-headless \
	unzip \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

ENV VERSION 3.1
ADD https://www.languagetool.org/download/LanguageTool-$VERSION.zip /LanguageTool-$VERSION.zip

RUN unzip LanguageTool-$VERSION.zip

WORKDIR /LanguageTool-$VERSION

CMD ["java", "-cp", "languagetool-server.jar", "org.languagetool.server.HTTPServer", "--port", "8010", "--public" ]
EXPOSE 8010
