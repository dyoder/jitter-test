# cache on by default
nocache?=false

build:
	sudo docker build --no-cache=$(nocache) --tag $(name) --rm=true ./
run:
	sudo docker run -i -p 127.0.0.1:9000:1337 --name $(name) -t $(name):latest /bin/bash
buildrun:
	sudo docker build --no-cache=$(nocache) --tag $(name) --rm=true ./ && \
	sudo docker run -i -p 127.0.0.1:9000:1337 --name $(name) -t $(name):latest /bin/bash

# http://sosedoff.com/2013/12/17/cleanup-docker-containers-and-images.html
cleanimages:
	sudo ./docker_scripts/cleanup/images
cleancontainers:
	sudo ./docker_scripts/cleanup/containers
cleanuntagged:
	sudo ./docker_scripts/cleanup/untagged

app:
	npm install && \
	coffee server.coffee
