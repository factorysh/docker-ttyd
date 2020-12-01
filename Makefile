TTYD_VERSION=1.6.1
CREDENTIAL:=beuha:aussi

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
		-tid \
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
		--name ttyd \
		-v `pwd`/tmp:/tmp/tmux \
		-e TMUX_TMPDIR=/tmp/tmux \
		-u `id -u` \
		-p 127.0.0.1:7681:7681 \
		-e CREDENTIAL=$(CREDENTIAL) \
		ttyd

up:
	echo "UID=`id -u`\nCREDENTIAL=$(CREDENTIAL)\nCOLUMNS=`tput cols`\nLINES=`tput lines`" > .env
	docker-compose up -d ttyd
	docker-compose ps
	docker-compose run -e COLUMNS=`tput cols` tmux tmux attach

down:
	docker-compose down

