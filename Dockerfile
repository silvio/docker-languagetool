FROM docker.io/library/eclipse-temurin:21

# see Makefile.version
ARG VERSION

LABEL maintainer="Silvio Fricke <silvio.fricke@gmail.com>"

RUN curl --remote-name https://languagetool.org/download/LanguageTool-"$VERSION".zip && \
    jar xvf ./LanguageTool-"$VERSION".zip && \
    rm LanguageTool-"$VERSION".zip

WORKDIR /LanguageTool-"$VERSION"

COPY misc/start.sh .
CMD [ "sh", "start.sh" ]
USER nobody
EXPOSE 8010
