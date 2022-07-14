VERSION  := 2022.6.1
CHECKSUM := ced6f082fa26f7b4806cc484cedd965d204d86c796ada14ee4c6a84fcf37c4a0
REGISTRY ?= localhost:5000
IMAGE    := $(REGISTRY)/tools/burp:$(VERSION)
DOCKER   ?= podman --runtime=/usr/bin/crun
WGET     := aria2c

ifneq ($(shell sha256sum burpsuite_community_linux_v*.sh | awk '{print $$1}'), $(CHECKSUM))
build: burpsuite_community_linux_v2022_6_1.sh
endif

ifneq ($(shell $(DOCKER) images --format='{{.Repository}}:{{.Tag}}' | grep -q $(IMAGE) && printf $$?), 0)
run: build
endif

run:
	$(DOCKER) run --rm -d \
		--env="DISPLAY=unix$(DISPLAY)" \
		--net host \
		--volume '/dev/shm:/dev/shm:rw' \
		--volume '/tmp/.X11-unix:/tmp/.X11-unix:ro' \
		$(IMAGE)

build:
	$(DOCKER) build \
		--build-arg GID=$(shell id -g) \
		--build-arg UID=$(shell id -u) \
		-t $(IMAGE) \
		.

push:
	$(DOCKER) push $(IMAGE)

burpsuite_community_linux_v2022_6_1.sh:
	$(WGET) -o $@ 'https://portswigger-cdn.net/burp/releases/download?product=community&version=$(VERSION)&type=Linux'
