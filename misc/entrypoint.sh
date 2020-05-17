#!/bin/bash

$PATH_TO_FILE="$GITHUB_WORKSPACE/$GITHUB_REPOSITORY/$2"
cat $PATH_TO_FILE
# java -jar /LanguageTool/languagetool-commandline.jar -l $1 $PATH_TO_FILE
