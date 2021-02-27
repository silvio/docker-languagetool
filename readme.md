
# Introduction

[LanguageTool] is an Open Source proof­reading software for English, French,
German, Polish, Dutch, and more than 20 other languages.

You can use LanguageTool with a [firefox] or [chrome] plugin to have proof reading in the browser.

This is a Dockerfile to get the languagetools running on an ARM system without java. 

The repository is forked from [silvio/docker-languagetool] and modified to run on ARM devices like the Raspberry Pi.

[LanguageTool]: https://www.languagetool.org/
[firefox]: https://addons.mozilla.org/firefox/addon/languagetoolfx/
[chrome]: https://chrome.google.com/webstore/detail/grammar-and-spell-checker/oldceeleldhonbafppcapldpdifcinji
[silvio/docker-languagetool]: https://github.com/silvio/docker-languagetool

# Usage

The Server is running on port 8010, this port should exposed.

    $ docker pull kelvinstuten/docker-languagetool-arm:latest
    [...]
    $ docker run --rm -p 8010:8010 kelvinstuten/docker-languagetool-arm:latest

Or you run it in background via `-d`-option.

Run with no minimum rights and RAM
```
docker run --name languagetool \
                        --cap-drop=ALL \
                        --user=65534:65534 \
                        --read-only \
                        --mount type=bind,src=/tmp/languagetool/tmp,dst=/tmp \
                        -p 127.0.0.1:8010:8010 \
                        --memory 412m --memory-swap 200m \
                        -e EXTRAOPTIONS="-Xmx382M" \
                        kelvinstuten/docker-languagetool-arm:latest
```

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
