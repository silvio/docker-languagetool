FROM openjdk:14-alpine

# see Makefile.version
ARG VERSION

MAINTAINER Silvio Fricke <silvio.fricke@gmail.com>

RUN apk add --no-cache libgomp gcompat libstdc++

RUN wget https://www.languagetool.org/download/LanguageTool-$VERSION.zip && \
    unzip LanguageTool-$VERSION.zip && \
    rm LanguageTool-$VERSION.zip

WORKDIR /LanguageTool-$VERSION

ADD misc/start.sh /start.sh
CMD [ "sh", "/start.sh" ]
USER nobody
EXPOSE 8010
