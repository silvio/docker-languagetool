
# Introduction

[LanguageTool] is an Open Source proof­reading software for English, French,
German, Polish, and more than 20 other languages.

You can use the LanguageTools with a [firefox-plugin].

This is a Dockerfile to get the languagetools running on a system without java.

[LanguageTool]: https://www.languagetool.org/
[firefox-plugin]: https://addons.mozilla.org/firefox/addon/languagetoolfx/

# Usage

The Server is running on port 8010, this port should exposed.

    $ docker pull silviof/docker-languagetool
    [...]
    $ docker run --rm -p 8010:8010 silviof/docker-languagetool

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
                        silviof/docker-languagetool:latest
```

## ngram support

To support [ngrams] you need an additional volume or directory mounted to the
`/ngrams` directory. For that add a `-v` to the `docker run`-command.

    docker run ... -v /path/to/ngrams:/ngrams ...

[ngrams]: http://wiki.languagetool.org/finding-errors-using-n-gram-data
