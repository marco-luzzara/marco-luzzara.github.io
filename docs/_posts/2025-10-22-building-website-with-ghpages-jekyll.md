---
title: "Building My Website With Github Pages and Jekyll"
categories:
  - Web Development
layout: single
tags:
  - Github Pages
  - Jekyll
---

> [**Check out the GitHub repository**][this-repo]

GitHub Pages is an amazing solution to deploy your personal website. It can be developed using Jekyll, a static site generator that converts HTML/Markdown into beautiful HTML pages.

This is not meant to be a tutorial on how Jekyll works, but rather I want to show you a few ways to develop your website in a clean and fast way.

## Requirements

- **Docker**, to test the website locally
- **VSCode** and **DevContainer** to develop faster

## Environment setup

In order to locally test the website, we need to write a simple `./Dockerfile`:

```Dockerfile
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
```

Note that the Jekyll version is retrieved from the [**Github Pages** dependencies page](https://pages.github.com/versions.json).

Then we create the `.devcontainer/devcontainer.json` file to open the repository inside a container using VSCode.

```json
{
    "build": {
        "dockerfile": "../Dockerfile"
    },
    "customizations": {
        "vscode": {
            "extensions": ["ms-vscode.makefile-tools"]
        }
    },
    "forwardPorts": [4000]
}
```

In this way, the VSCode container is built upon the image built using the specified *Dockerfile*. Besides, we can optionally install the *Makefile* extension, or any other extensions, using the `customizations` section. 

Now, from VSCode -> *Reopen in Container*, the image should build and you can use Jekyll commands directly from inside a shell inside VSCode. This has the advantage that you do not have to install any package, but everything is contained in a Docker container.

## Jekyll Operations

I personally recommend you to run the `jekyll new --skip-bundle .` command inside the `./docs` folder. In this way, the `Dockerfile` and any additional file are kept separated from the site's resources. For the other Jekyll commands, I prefer to put them in a Makefile:

```makefile
SHELL=/bin/bash
SITE_FOLDER := docs

.PHONY: install
install:
	cd ${SITE_FOLDER} && bundle install


.PHONY: run
run: install
	cd ${SITE_FOLDER} && bundle exec jekyll serve
```

In this case, it is very simple and two commands are available:

- `make install`: install the dependencies listed in the `Gemfile`
- `make run`: run the server on port 4000

After executing `make run`, you can visit your website on `http://localhost:4000`.

For the site-specific configurations, please check out the [repository][this-repo], the Jekyll documentation, and the chosen theme documentation ([minimal-mistake](https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/) in this case).

[this-repo]: https://github.com/{{ site.repository }}
