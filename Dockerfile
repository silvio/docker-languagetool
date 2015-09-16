FROM debian:jessie

MAINTAINER Silvio Fricke <silvio.fricke@gmail.com>

RUN dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get install -y openjdk-7-jre git-core unzip \
    && apt-get clean -y

ADD https://www.languagetool.org/download/LanguageTool-2.9.zip /LanguageTool-2.9.zip

RUN unzip LanguageTool-2.9.zip

WORKDIR /LanguageTool-2.9

CMD ["java", "-cp", "languagetool-server.jar", "org.languagetool.server.HTTPServer", "--port", "8010", "--public" ]
EXPOSE 8010
