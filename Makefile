docker:
	sudo docker build .
dockerRemoveContainers:
	docker rm `docker ps --no-trunc -a -q`
run:
	sudo docker run -p 127.0.0.1:9000:1337 --name JITTERBUG #{image_id} -i -t /bin/bash
app:
	npm install && \
	coffee server.coffee
