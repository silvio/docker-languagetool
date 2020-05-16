#!/bin/bash

echo "hello Wrodl"
ls -l
# java -jar languagetool-commandline.jar -l $1 --json ${EXTRAOPTIONS} - $2
java -jar languagetool-commandline.jar -l $1 $2
