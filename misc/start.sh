#!/bin/bash
# SPDX-License-Identifier: LGPL-3.0-or-later

EXTRAOPTIONS=""
[ -d "/ngrams" ] && EXTRAOPTIONS=" --languageModel /ngrams "

java -cp languagetool-server.jar  org.languagetool.server.HTTPServer --port 8010 --public --allow-origin '*' ${EXTRAOPTIONS}
