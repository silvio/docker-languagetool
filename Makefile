# SPDX-License-Identifier: LGPL-3.0-or-later

include Makefile.version

envout:
	@echo "VERSION=$(VERSION)"
	@echo "UNPACKED_VERSION=$(UNPACKED_VERSION)"
	@echo "BUILDARG_VERSION=$(BUILDARG_VERSION)"
	@echo "IMAGENAME=$(IMAGENAME)"
	@echo "BUILDARG_PLATFORM=$(BUILDARG_PLATFORM)"

prepare:
	sudo apt-get -qq -y install curl jq

build: download
	docker buildx build $(BUILDARG_VERSION) $(BUILDARG_PLATFORM) -t $(IMAGENAME):latest .
	docker buildx build $(BUILDARG_VERSION) --load -t $(IMAGENAME):latest .

download: languagetool-$(VERSION).zip
	-rm -rf LanguageTool-$(VERSION) LanguageTool-$(UNPACKED_VERSION)
	echo ":: unzipping languagetool-$(VERSION).zip"
	unzip -o languagetool-$(VERSION).zip 2>&1 1>/dev/null

languagetool-$(VERSION).zip:
	curl -L https://github.com/languagetool-org/languagetool/archive/refs/tags/v$(VERSION).zip -o languagetool-$(VERSION).zip

.PHONY: test
test:
	misc/test.sh $(IMAGENAME):latest $(VERSION)

.PHONY: tag
tag: tag-push

.PHONY: tag-push
tag-push:
	docker buildx build $(BUILDARG_VERSION) $(BUILDARG_PLATFORM) -t $(IMAGENAME):latest . --push
	docker buildx build $(BUILDARG_VERSION) $(BUILDARG_PLATFORM) -t $(IMAGENAME):$(VERSION) . --push
