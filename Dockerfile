# Use alpine as "builder"
FROM alpine:latest as builder

# Install git
RUN apk update
RUN apk add git

# Clone H5P repositories
RUN git clone https://github.com/h5p/h5p-php-library
RUN git clone https://github.com/h5p/h5p-editor-php-library

# Remove unused files
RUN rm h5p-php-library/*.php
RUN rm h5p-editor-php-library/*.php

# Use nginx as server
FROM nginx:alpine

# Copy configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy H5P files to webroot
RUN rm -r /usr/share/nginx/html/*
COPY --from=builder /h5p-php-library /usr/share/nginx/html/core
COPY --from=builder /h5p-editor-php-library /usr/share/nginx/html/editor

EXPOSE 8080