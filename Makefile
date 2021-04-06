
include Makefile.version

prepare:
	sudo apt-get -qq -y install curl

build:
	docker build $(BUILDARG_VERSION) -t silvio/docker-languagetool:latest .
	docker tag silvio/docker-languagetool:latest silvio/docker-languagetool:$(VERSION)

test: test-cleanup.1
test: TESTIPADDRESS=$(subst ",,$(shell docker inspect languagetool | jq '.[0].NetworkSettings.IPAddress'))
test: test-print-ip-address
test: test-start
test: test-run-test-lang
test: test-run-test-en
test: test-run-test-fr
test: test-cleanup.2

test-start:
	docker run -d --name languagetool -p 8010:8010 silvio/docker-languagetool
	sleep 3

test-print-ip-address:
	@echo "IP address of languagetools docker container: $(TESTIPADDRESS)"

test-run-test-lang:
	curl \
		-X GET \
		--header 'Accept: application/json' \
		'http://$(TESTIPADDRESS):8010/v2/languages'

test-run-test-en:
	curl \
		-X POST \
		--header 'Content-Type: application/x-www-form-urlencoded' \
		--header 'Accept: application/json' \
		-d 'text=hello%20woorld&language=en-US&motherTongue=de-DE&enabledOnly=false' \
		'http://$(TESTIPADDRESS):8010/v2/check'

test-run-test-fr:
	curl -X POST \
		--header 'Content-Type: application/x-www-form-urlencoded' \
		--header 'Accept: application/json' \
		-d 'text=hello%20woorld&language=fr&motherTongue=de-DE&enabledOnly=false' \
		'http://$(TESTIPADDRESS):8010/v2/check'

.PHONY: test-cleanup
test-cleanup.%:
	-docker stop languagetool
	-docker rm languagetool

.PHONY: tag
tag: tag-push

.PHONY: tag-push
tag-push: build
tag-push:
	docker push silvio/docker-languagetool:latest
	docker push silvio/docker-languagetool:$(VERSION)
