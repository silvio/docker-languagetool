FROM openjdk:14-alpine

MAINTAINER Silvio Fricke <silvio.fricke@gmail.com>

RUN apk add --no-cache libgomp gcompat libstdc++

ENV VERSION 4.9.1
RUN wget https://www.languagetool.org/download/LanguageTool-$VERSION.zip && \
    unzip LanguageTool-$VERSION.zip && \
    rm LanguageTool-$VERSION.zip

WORKDIR /LanguageTool-$VERSION

ADD misc/start.sh /start.sh
CMD [ "sh", "/start.sh" ]
USER nobody
EXPOSE 8010
