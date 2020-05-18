#!/bin/bash

FILE_TO_PARSE=$2
PATH_TO_FILE="$FILE_TO_PARSE"
LOGFILE="$(date +%s).txt"
java -jar /LanguageTool/languagetool-commandline.jar -l $1 --json $PATH_TO_FILE >> $LOGFILE
python3 /parse_log.py $FILE_TO_PARSE $LOGFILE
