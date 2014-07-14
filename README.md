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
3. `make buildrun cname=CONTAINER_NAME iname=IMAGE_NAME [nocache=true]`  
 `buildrun` should take a minute or two your first time (because lack of cache).  
 `nocache=true` (defaulted to false)  will re-download base/arch and rebuild image.  
 After you've got your container shell running:  
4. `redis-server &`
5. `cd jitter-test`
6. `make app`
7. on your local machine, try

```
curl -XPUT localhost:9000/weather/santa-monica -d'70 degrees and sunny'
curl localhost:9000/weather/santa-monica
```
The result should read "70 degrees and sunny."
(The docker container's virtual port 1337 should be exposed to the local port 9000 by preset)

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





