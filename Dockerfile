FROM adoptopenjdk/openjdk14:aarch64-ubuntu-jre-14.0.2_12

RUN apt-get update -y \
    && apt-get install -y \
        wget \
        unzip

ENV VERSION 5.2
RUN wget https://www.languagetool.org/download/LanguageTool-5.2.zip && \
    unzip LanguageTool-5.2.zip && \
    rm LanguageTool-5.2.zip

WORKDIR /LanguageTool-5.2

ADD misc/start.sh /start.sh
CMD [ "sh", "/start.sh" ]
USER nobody
EXPOSE 8010
