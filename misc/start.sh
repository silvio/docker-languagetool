#!/bin/bash

EXTRAOPTIONS=${EXTRAOPTIONS:-}
[ -d "/ngrams" ] && EXTRAOPTIONS="${EXTRAOPTIONS} --languageModel /ngrams"

java -cp languagetool-server.jar  org.languagetool.server.HTTPServer --port 8010 --public --allow-origin '*' ${EXTRAOPTIONS}
