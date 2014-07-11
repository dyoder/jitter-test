docker:
	sudo docker build ../jitter-test
run:
	sudo docker run -i -t /bin/bash
app:
	npm install && \
	coffee server.coffee
