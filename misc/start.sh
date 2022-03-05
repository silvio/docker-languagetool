#!/bin/bash

EXTRAOPTIONS=${EXTRAOPTIONS:-}
JAVAOPTIONS=${JAVAOPTIONS:-}
[ -d "/ngrams" ] && EXTRAOPTIONS="${EXTRAOPTIONS} --languageModel /ngrams"

java ${JAVAOPTIONS} -cp languagetool-server.jar org.languagetool.server.HTTPServer --port 8010 --public --allow-origin '*' ${EXTRAOPTIONS}
