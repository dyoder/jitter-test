FROM base/arch

# Set locale
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Configure the environment
ENV PATH ./node_modules/.bin:$PATH

# Install Node.js
RUN  pacman -Syu --noconfirm --ignore filesystem
RUN  pacman -S --noconfirm nodejs
RUN  pacman -S git --noconfirm
RUN  git clone https://github.com/peterlnguyen/jitter-test.git
RUN  cd jitter-test
RUN  npm install
RUN  npm install coffee-script -g --save
RUN  pacman -S --noconfirm redis
RUN  redis-server &
RUN  coffee server.coffee &

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
