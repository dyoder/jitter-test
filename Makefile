buildrun:
	sudo docker build --tag $(name) --rm=true ./ && \
	sudo docker run -i -p 127.0.0.1:9000:1337 --name $(name) -t $(name):latest /bin/bash
build:
	sudo docker build --tag="$(name)" ./
run:
	sudo docker run -i -p 127.0.0.1:9000:1337 --name $(name) -t $(name):latest /bin/bash

cleanimages:
	sudo ./docker_scripts/cleanup/images
cleancontainers:
	sudo ./docker_scripts/cleanup/containers
cleanuntagged:
	sudo ./docker_scripts/cleanup/untagged

app:
	npm install && \
	coffee server.coffee
