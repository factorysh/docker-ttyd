TTYD_VERSION=1.6.1

image-build:
	docker build \
		-t ttyd \
		-f Dockerfile \
		--build-arg TTYD_VERSION=$(TTYD_VERSION) \
		.

