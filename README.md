Docker Setup
============

Requirements:
1. docker
2. make (nix systems)

-----------
Quickstart:
-----------

1. `git clone https://github.com/peterlnguyen/jitter-test.git`
2. `cd jitter-test`
3. `docker build . -t jitter`  

This will take a few minutes the first time you do it. You'll get output along the lines of: `Successfully built c0d40381300c`.

4. `docker -p 9000:1337  --name jitter -t jitter:latest`

This will map port `9000` to the container's `1337` port.

5. Test it out:

```
curl -XPUT localhost:9000/weather/santa-monica -d'70 degrees and sunny'
curl localhost:9000/weather/santa-monica
```

The result should read `70 degrees and sunny`.

-----------------
Basic Terminology
-----------------

- image: recipes prepared by others (e.g. base/arch, centos, ubuntu:12.04)
  https://github.com/dotcloud/docker/wiki/Public-docker-images

- container: an instance of an image (e.g. a running server with CLI access)

-----------
Cleaning Up
-----------

- containers: `make cleancontainers`
  will stop running containers, will remove all containers.

- images: `make cleanimages`
  WARNING - because running containers have a dependency on their image, removing images
  necessitates stopping and removing containers as well.
