FROM base/arch

# Set locale
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Configure the environment
ENV PATH ./node_modules/.bin:$PATH

# Install Node.js
RUN \
  pacman -Syu --noconfirm && \
  pacman -S --noconfirm nodejs && \
  git clone https://github.com/peterlnguyen/jitter-test.git && \
  cd jitter-test && \
  npm install && \
  cd jitter && \
  npm install && \
  cd .. && \
  npm install coffee-script -g --save && \
  pacman -S --noconfirm redis-server && \
  systemd redis-server start && \
  coffee server.coffee
