# https://registry.hub.docker.com/u/base/archlinux/
FROM base/arch

# Set locale
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Configure the environment
ENV PATH ./node_modules/.bin:$PATH

# install required software
RUN pacman -Syu --noconfirm --ignore filesystem
RUN pacman -S --noconfirm nodejs
RUN pacman -S --noconfirm make
RUN pacman -S --noconfirm git

RUN npm install coffee-script -g --save
RUN pacman -S --noconfirm redis

RUN redis-server &

# install test app
RUN git clone https://github.com/peterlnguyen/jitter-test.git
RUN cd jitter-test && npm install
RUN coffee server.coffee &

# expose virtual port to host machine
EXPOSE 1337

# Install Node.js
#RUN \
#  pacman -Syu --noconfirm --ignore filesystem && \
#  pacman -S filesystem --force && \
#  pacman -S --noconfirm nodejs && \
#  pacman -S git --noconfirm && \
#  git clone https://github.com/peterlnguyen/jitter-test.git && \
#  cd jitter-test && \
#  npm install && \
#  npm install coffee-script -g --save && \
#  pacman -S --noconfirm redis && \
#  (redis-server &) && \
#  coffee server.coffee &
