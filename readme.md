
# Introduction

[LanguageTool](https://languagetool.org/) is an Open Source proof­reading software for English, French,
German, Polish, and more than 20 other languages.

This version is based on the version of [silvio/docker-languagetool](https://github.com/silvio/docker-languagetool) but modified to run on ARM devices like the Raspberry Pi. 

## ngram support

To support [ngrams] you need an additional volume or directory mounted to the
`/ngrams` directory. For that add a `-v` to the `docker run`-command.

    docker run ... -v /path/to/ngrams:/ngrams ...

[ngrams]: http://wiki.languagetool.org/finding-errors-using-n-gram-data


Download English ngrams with the commands:

    mkdir ngrams
    wget https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip
    (cd ngrams && unzip ../ngrams-en-20150817.zip)
    rm -f ngrams-en-20150817.zip


One can use them using web browser plugin "Local server (localhost)" setting by running:

    docker run -d --name languagetool -p 127.0.0.1:8081:8010 -v `pwd`/ngrams:/ngrams:ro --restart=unless-stopped kelvinstuten/languagetool-arm
