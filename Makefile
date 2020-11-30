TTYD_VERSION=1.6.1

image-ttyd:
	docker build \
		-t ttyd \
		--build-arg TTYD_VERSION=$(TTYD_VERSION) \
		.

image-tmux:
	docker build \
		-t tmux \
		-f Dockerfile.tmux \
		.

images: image-tmux image-ttyd

run-tmux:
	mkdir -p tmp
	docker run \
		-t \
		-d \
		--rm \
		--name tmux \
		-u `id -u` \
		-e TMUX_TMPDIR=/tmp/tmux \
		-v `pwd`/tmp:/tmp/tmux \
		tmux

run-ttyd:
	mkdir -p tmp
	docker run \
		-t \
		-d \
		--rm \
		-v `pwd`/tmp:/tmp/tmux \
		-e TMUX_TMPDIR=/tmp/tmux \
		-u `id -u` \
		-p 7681:7681 \
		-e CREDENTIAL=beuha:aussi \
		ttyd

run: | run-tmux run-ttyd
	docker exec -ti tmux tmux attach
