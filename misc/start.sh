#!/bin/bash

java -jar languagetool-commandline.jar -l $1 --json ${EXTRAOPTIONS} - $2
