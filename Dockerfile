# SPDX-License-Identifier: LGPL-3.0-or-later
FROM docker.io/library/eclipse-temurin:19

# see Makefile.version
ARG VERSION
ARG UNPACKED_VERSION

LABEL maintainer="Silvio Fricke <silvio.fricke@gmail.com>"

ADD ./LanguageTool-"${UNPACKED_VERSION}" /LanguageTool-"${UNPACKED_VERSION}"

WORKDIR /LanguageTool-"${UNPACKED_VERSION}"

COPY misc/start.sh .
CMD [ "sh", "start.sh" ]
USER nobody
EXPOSE 8010
