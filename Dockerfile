FROM openjdk:slim

ARG VERSION=5.6

RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*

RUN wget https://www.languagetool.org/download/LanguageTool-$VERSION.zip && \
    unzip LanguageTool-$VERSION.zip && \
    rm LanguageTool-$VERSION.zip

WORKDIR /LanguageTool-$VERSION

ADD misc/start.sh /start.sh
CMD [ "sh", "/start.sh" ]
USER nobody
EXPOSE 8010
