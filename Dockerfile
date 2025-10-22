# syntax=docker/dockerfile:1

ARG UBUNTU_VERSION=24.04

FROM ubuntu:${UBUNTU_VERSION}

# install ruby
RUN <<EOF
    apt update    
    apt install -y ruby-full build-essential zlib1g-dev
EOF

# Rename `ubuntu` user to `jekyll`
RUN <<EOF
    groupmod -n jekyll ubuntu
    usermod -l jekyll -d /home/jekyll -m -c Jekyll -s /bin/bash ubuntu
EOF

USER jekyll

# Install Ruby Gems to ~/gems'
ENV GEM_HOME="/home/jekyll/gems"
ENV PATH="/home/jekyll/gems/bin:${PATH}"

# Install jekyll and bundler
RUN <<EOF
    gem install jekyll -v 3.10.0 
    gem install bundler
EOF

ENV LC_ALL="C.UTF-8"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"