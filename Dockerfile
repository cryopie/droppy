FROM node:alpine

WORKDIR /droppy
COPY ./ /droppy
RUN npm install .

# Install build dependencies and and build modules
RUN cd /droppy && \
  find /droppy -type d -exec chmod 0755 {} + && \
  find /droppy -type f -exec chmod 0644 {} + && \
  chmod 0755 /droppy/docker-start.sh && \
  chmod 0755 /droppy/droppy.js && \
  mkdir -p /root/.droppy && \
  ln -s /config /root/.droppy/config && \
  ln -s /files /root/.droppy/files && \
  ln -s /droppy/droppy.js /usr/bin/droppy && \
  rm -rf \
    /root/.config \
    /root/.node-gyp \
    /root/.npm \
    /tmp/* \
    /usr/lib/node_modules \
    /usr/local/lib/node_modules \
    /usr/local/share/.cache

EXPOSE 8989
VOLUME ["/config", "/files"]
CMD ["/droppy/docker-start.sh"]
