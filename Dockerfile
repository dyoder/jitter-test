# https://registry.hub.docker.com/u/base/archlinux/
FROM base/arch

# Set locale
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Configure the environment
ENV PATH ./node_modules/.bin:$PATH

# install required software
RUN pacman -Syu --noconfirm --ignore filesystem
RUN pacman -S --noconfirm python2
RUN pacman -S --noconfirm nodejs
RUN pacman -S --noconfirm make
RUN pacman -S --noconfirm git

RUN npm install coffee-script -g --save
RUN pacman -S --noconfirm redis

# install test app
ADD package.json /package.json
ADD server.coffee /server.coffee
RUN npm install
CMD npm run start

# expose virtual port to host machine
EXPOSE 1337
