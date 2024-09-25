#!/usr/bin/env bash
# SPDX-License-Identifier: LGPL-3.0-or-later

EXTRAOPTIONS=${EXTRAOPTIONS:-}
JAVAOPTIONS=${JAVAOPTIONS:-}

if [ -d "/ngrams" ]; then
    EXTRAOPTIONS="${EXTRAOPTIONS} --languageModel /ngrams"
fi

# iterate over environment variables starting with LT_
# and write their names without the LT_ prefix and
# their values to /tmp/config.properties
for var in ${!LT_*}; do
  EXTRA_LT=true
  echo "${var#'LT_'}="${!var} >> /tmp/config.properties
done

echo JAVAOPTIONS=$JAVAOPTIONS
if [ "$EXTRA_LT" = true ]; then
  EXTRAOPTIONS="${EXTRAOPTIONS} --config /tmp/config.properties"
    echo config.properties:
    echo "$(cat /tmp/config.properties)"
fi
echo EXTRAOPTIONS=$EXTRAOPTIONS

java ${JAVAOPTIONS} -cp languagetool-server.jar org.languagetool.server.HTTPServer --port 8010 --public --allow-origin '*' ${EXTRAOPTIONS}
