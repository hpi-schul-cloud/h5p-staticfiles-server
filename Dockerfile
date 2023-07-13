# Use Debian "builder" for build stage
FROM docker.io/debian:bullseye as builder

# Install git
RUN apt-get update
RUN apt-get install -y git

# Clone H5P repositories
RUN git clone https://github.com/h5p/h5p-php-library
RUN git clone https://github.com/h5p/h5p-editor-php-library

# Remove unused files
RUN rm h5p-php-library/*.php
RUN rm h5p-editor-php-library/*.php

# Use nginx as server for run stage
FROM docker.io/nginx:1.25

# Copy configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy H5P files to webroot
RUN rm -r /usr/share/nginx/html/*
COPY --from=builder /h5p-php-library /usr/share/nginx/html/core
COPY --from=builder /h5p-editor-php-library /usr/share/nginx/html/editor

RUN chown -R nginx:nginx /usr/share/nginx && \
        chown -R nginx:nginx /var/cache/nginx && \
        chown -R nginx:nginx /etc/nginx

RUN touch /var/run/nginx.pid && \
        chown -R nginx:nginx /var/run/nginx.pid
USER nginx

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]