FROM adoptopenjdk/openjdk14:aarch64-ubuntu-jre-14.0.2_12
# FROM adoptopenjdk/openjdk14:latest
COPY qemu-arm-static /usr/bin

RUN apt-get update -y \
    && apt-get install -y \
        wget \
        unzip

ENV VERSION 5.2
RUN wget https://www.languagetool.org/download/LanguageTool-$VERSION.zip && \
    unzip LanguageTool-$VERSION.zip && \
    rm LanguageTool-$VERSION.zip

WORKDIR /LanguageTool-$VERSION

ADD misc/start.sh /start.sh
CMD [ "sh", "/start.sh" ]
USER nobody
EXPOSE 8010
