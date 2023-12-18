# SPDX-License-Identifier: LGPL-3.0-or-later
FROM docker.io/library/eclipse-temurin:19

# see Makefile.version
ARG VERSION

LABEL maintainer="Silvio Fricke <silvio.fricke@gmail.com>"

ADD ./LanguageTool-"${VERSION}" /LanguageTool-"${VERSION}"

WORKDIR /LanguageTool-"$VERSION"

COPY misc/start.sh .
CMD [ "sh", "start.sh" ]
USER nobody
EXPOSE 8010
