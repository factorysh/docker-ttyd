TTYD_VERSION=1.6.2
CREDENTIAL:=beuha:aussi

image-ttyd:
	docker build \
		-t ttyd \
		--build-arg TTYD_VERSION=$(TTYD_VERSION) \
		.

image-tmux:
	docker build \
		-t tmux \
		--build-arg UID=`id -u` \
		-f Dockerfile.tmux \
		.

image-agent:
	docker build \
		-t ttyd-agent \
		--build-arg UID=`id -u` \
		-f Dockerfile.agent \
	.

images: image-tmux image-ttyd image-agent

run-agent:
	docker run \
		--rm \
		-d \
		-h ssh-agent \
		--name=ttyd-agent \
		ttyd-agent

run-tmux:
	mkdir -p tmp
	mkdir -p home
	docker run \
		-tid \
		--rm \
		-h tmux \
		--volumes-from=ttyd-agent \
		--name tmux \
		-e SSH_AUTH_SOCK=/secret/ssh-agent.sock \
		-e TMUX_TMPDIR=/tmp/tmux \
		-v `pwd`/tmp:/tmp/tmux \
		-v `pwd`/home:/home/user \
		-w /home/user \
		tmux

run-ttyd:
	mkdir -p tmp
	docker run \
		-t \
		-d \
		--rm \
		-h ttyd \
		--name ttyd \
		-v `pwd`/tmp:/tmp/tmux \
		-e TMUX_TMPDIR=/tmp/tmux \
		-u `id -u` \
		-p 127.0.0.1:7681:7681 \
		-e CREDENTIAL=$(CREDENTIAL) \
		ttyd

run: | run-agent run-tmux run-ttyd
	docker attach tmux

down:
	docker kill ttyd-agent
	docker kill tmux
	docker kill ttyd

