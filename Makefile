
prepare:
	sudo apt-get -qq -y install curl

build:
	docker build -t silvio/docker-languagetool .

test:
	docker run -d --name languagetool -p 8010:8010 silvio/docker-languagetool
	sleep 5

	echo "get all languages"
	curl -X GET --header 'Accept: application/json' 'http://172.17.0.1:8010/v2/languages'

	echo "test en-US"
	curl -X POST --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json' -d 'text=hello%20woorld&language=en-US&motherTongue=de-DE&enabledOnly=false' 'http://172.17.0.1:8010/v2/check'

	echo "test fr"
	curl -X POST --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json' -d 'text=hello%20woorld&language=fr&motherTongue=de-DE&enabledOnly=false' 'http://172.17.0.1:8010/v2/check'
stop:
	docker stop languagetool
	docker rm languagetool

