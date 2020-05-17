#!/bin/bash

PATH_TO_FILE="$GITHUB_WORKSPACE/$2"
java -jar /LanguageTool/languagetool-commandline.jar -l $1 $PATH_TO_FILE
