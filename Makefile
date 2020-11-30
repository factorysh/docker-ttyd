TTYD_VERSION=1.6.1

build: src/ttyd/build/ttyd.$(TTYD_VERSION)

src/ttyd/README.md:
	git submodule update

image-build:
	docker build -t ttyd-dev -f Dockerfile.build .

src/ttyd/build/ttyd.$(TTYD_VERSION): src/ttyd/README.md
	mkdir -p src/ttyd/build
	cd src/ttyd && git checkout $(TTYD_VERSION)
	docker run --rm \
		-v `pwd`/src/ttyd:/src \
		-w /src/build \
		-u `id -u` \
		ttyd-dev \
		bash -c "cmake .. && make && upx ttyd"
	touch src/ttyd/build/ttyd.$(TTYD_VERSION)
