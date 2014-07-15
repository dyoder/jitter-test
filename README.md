-----------
Quickstart:
-----------

1. `git clone https://github.com/dyoder/jitter-test.git`
2. `cd jitter-test`
3. `docker build -t jitter .`  

This will take a few minutes the first time you do it. You'll get output along the lines of: `Successfully built c0d40381300c`.

4. `docker run -p 9000:1337  --name jitter -t jitter:latest`

This will map port `9000` to the container's `1337` port.

5. Test it out:

```
curl -XPUT localhost:49000/weather/santa-monica -d'70 degrees and sunny'
curl localhost:49000/weather/santa-monica
```

The result should read `70 degrees and sunny`.

-----------------
Basic Terminology
-----------------


-----------
Cleaning Up
-----------

To stop all running containers:

```
docker stop `docker ps -a -q`
```

To remove all containers:

```
docker rm -f `docker ps -a -q`
```
