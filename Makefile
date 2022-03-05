
LANGUAGETOOL_VERSION := 5.6
TRIVY_VERSION := 0.24.2

BUILDARG_VERSION := --build-arg VERSION=$(LANGUAGETOOL_VERSION)
IMAGENAME := docker.io/silviof/docker-languagetool
BUILDARG_PLATFORM := --platform linux/amd64,linux/arm64/v8

ci-deps:
	apt-get -qq -y install \
		curl \
		wget \
		ca-certificates \
		gnupg \
		lsb-release \
		qemu-user-static \
		binfmt-support

ci-deps-docker:
	curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
	echo "deb [arch=$(shell dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(shell lsb_release -cs) stable" |\
	tee /etc/apt/sources.list.d/docker.list > /dev/null && \
	cat /etc/apt/sources.list.d/docker.list && \
	apt-get update && \
	apt-get -qq -y install \
		docker-ce \
		docker-ce-cli \
		containerd.io

ci-deps-trivy:
	wget https://github.com/aquasecurity/trivy/releases/download/v$(TRIVY_VERSION)/trivy_$(TRIVY_VERSION)_Linux-64bit.deb && \
	dpkg -i trivy_$(TRIVY_VERSION)_Linux-64bit.deb

ci-setup-buildx:
	docker run --privileged --rm tonistiigi/binfmt --install all
	docker buildx create --name mybuilder
	docker buildx use mybuilder

ci-prepare: ci-deps ci-deps-docker ci-deps-trivy ci-setup-buildx

ci-build: ci-prepare
	docker buildx build $(BUILDARG_VERSION) $(BUILDARG_PLATFORM) -t $(IMAGENAME):latest .
	docker buildx build $(BUILDARG_VERSION) --load -t $(IMAGENAME):latest .

trivy:
	trivy i \
		--ignore-unfixed \
		--exit-code 1 \
		$(IMAGENAME):latest

docker-%:
	docker run \
		--rm \
		--privileged -v /var/run/docker.sock:/var/run/docker.sock \
		-v $(shell pwd):/data \
		-w /data \
		debian:stable sh -c "apt-get update && apt-get install make && make $*"

.PHONY: tag
tag: tag-push

.PHONY: tag-push
tag-push:
	docker buildx build $(BUILDARG_VERSION) $(BUILDARG_PLATFORM) -t $(IMAGENAME):latest . --push
	docker buildx build $(BUILDARG_VERSION) $(BUILDARG_PLATFORM) -t $(IMAGENAME):$(VERSION) . --push
