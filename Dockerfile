FROM alpine:3.5

MAINTAINER Silvio Fricke <silvio.fricke@gmail.com>

ENV VERSION 3.6
ADD https://www.languagetool.org/download/LanguageTool-$VERSION.zip /LanguageTool-$VERSION.zip

RUN apk update \
    && apk add \
	openjdk8-jre-base \
	unzip \
    && rm -rf /var/cache/apk \
    && unzip LanguageTool-$VERSION.zip \
    && rm LanguageTool-$VERSION.zip

WORKDIR /LanguageTool-$VERSION

CMD ["java", "-cp", "languagetool-server.jar", "org.languagetool.server.HTTPServer", "--port", "8010", "--public" ]
EXPOSE 8010
