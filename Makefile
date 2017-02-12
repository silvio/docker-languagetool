
prepare:
	sudo apt-get -qq -y install curl

build:
	docker build -t silvio/docker-languagetool .

test:
	docker run -d --name languagetool -p 8010:8010 silvio/docker-languagetool
	sleep 5
	curl -X GET --header 'Accept: application/json' 'http://172.17.0.1:8010/v2/languages'

stop:
	docker stop languagetool
	docker rm languagetool

