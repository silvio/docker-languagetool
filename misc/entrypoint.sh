#!/bin/bash

java -jar /LanguageTool/languagetool-commandline.jar -l $1 $GITHUB_WORKSPACE/$2
