#!/bin/bash

EXTRAOPTIONS=""
[ -d "/ngrams" ] && EXTRAOPTIONS=" --languageModel /ngrams "

java -jar languagetool-commandline.jar -l $1 --json ${EXTRAOPTIONS} - $2
