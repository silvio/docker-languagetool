
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
