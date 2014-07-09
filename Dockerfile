#
# Node.js Dockerfile
#
# https://github.com/dockerfile/nodejs
#

# Pull base image.
FROM dockerfile/python

# Install Node.js
RUN \
  cd /tmp && \
  wget http://nodejs.org/dist/node-latest.tar.gz && \
  tar xvzf node-latest.tar.gz && \
  rm -f node-latest.tar.gz && \
  cd node-v* && \
  ./configure && \
  CXX="g++ -Wno-unused-local-typedefs" make && \
  CXX="g++ -Wno-unused-local-typedefs" make install && \
  cd /tmp && \
  rm -rf /tmp/node-v* && \
  echo '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bash_profile

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]

# install and run app
RUN \
  git clone https://github.com/peterlnguyen/jitter-test.git && \

  # install dependencies for the test app using jitter
  cd jitter-test && \
  npm install && \

  # install dependencies for jitter
  cd jitter && \
  npm install && \
  cd .. && \

  # install coffee-script
  apt-get install coffee-script -g --save && \

  # install and run redis-server
  apt-get install redis-server
  service redis-server start

  # run app
  coffee server.coffee
