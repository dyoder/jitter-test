docker:
	sudo docker build .
run:
	sudo docker run -p 127.0.0.1:9000:1337 --name JITTERBUG -i -t /bin/bash
app:
	npm install && \
	coffee server.coffee
