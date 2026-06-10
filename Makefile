IMAGE ?= ghcr.io/michalg-/docker-timemachine
TAG ?= latest
PLATFORMS ?= linux/amd64,linux/arm64

.PHONY: build release
build:
	docker build -t $(IMAGE):$(TAG) .

release:
	docker buildx build --platform $(PLATFORMS) -t $(IMAGE):$(TAG) --push .
