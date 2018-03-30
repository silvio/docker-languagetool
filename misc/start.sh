#!/bin/bash

java -cp languagetool-server.jar  org.languagetool.server.HTTPServer --port 8010 --public --allow-origin '*'
