---
title: "Building My Website With Github Pages and Jekyll"
categories:
  - Web Development
layout: single
tags:
  - Github Pages
  - Jekyll
---

> [**Check out this GitHub repository**](https://github.com/{{ site.repository }})

Building websites is not my favorite activity, but, nowadays, many tools exist to help you. I needed a straightforward presentation website, so I chose Github Pages to host it for free. GitHub Pages also seems very well integrated with Jekyll, a static site generator that converts Markdown into beautiful HTML pages. This post is not a tutorial because you can find a lot of resources that already have that purpose. Instead, I am just going to share some thoughts and knowledge that could have been useful when I started this.

GitHub Pages' documentation is well done, but it understandably assumes that you are going to locally install Jekyll on your machine. As a fan of Docker, I created a `docker-compose.yml` and a `Makefile` for some `PHONY` shortcuts. This is the `Jekyll` service that I have used to create and build the website:

```yaml
jekyll:
  build: 
    context: .
    dockerfile_inline: |
      FROM jekyll/jekyll:3.8.6
      RUN gem update --system 3.3.22
  image: github-jekyll
  volumes:
    - ./docs:/srv/jekyll
    - ./vendor/bundle:/usr/local/bundle
```

The Jekyll version is fixed to `3.8.6`, although the `latest` version on Docker Hub is the 4th major. However, [Github Pages is still using the 3rd major](https://pages.github.com/versions/), and the `3.8.6` is the latest available for that major version. 

As for the volumes, the site's tree is mapped to the `/srv/jekyll` folder, while the `./vendor/bundle` folder works as a cache for the Jekyll dependencies.

---

## Create the Jekyll Project

To create a new Jekyll project, run `make create-site` with these variables:
- `THEME_GEM_ID` (like `"minima", "~> 2.0"` for the Jekyll default theme), which is passed to the `gem` command to install the theme. **Note:** installing the theme is not always necessary as `jekyll-remote-theme` should do it for you.  
- `THEME_NAME`, that corresponds to the `{USER_OWNER}/{REPO_NAME}` of the GitHub repository hosting the theme's implementation (e.g. `jekyll/minima` for the default theme)

Likewise, to change the theme, run `make change-theme` with the same variables. Changing the theme in this way is not enough for complex themes (like *Minimal Mistakes*), so you probably still need to modify the `_config.yml` file accordingly.

---

## Build and Serve the Website

Building and serving the website is overly simple: `make serve`. It spawns a new container that exposes port 4000, which is mapped to your local 4000 port, by default. To change this behavior, append `JEKYLL_PORT={YOUR_PORT}` to the `make serve` command. Then, your website will be locally available on `127.0.0.1:{JEKYLL_PORT}`.

---

## Too Many Themes... Which One Fits My Needs?

GitHub Pages provides a dozen of in-built themes, but, honestly, I don't like them. I tried [Hyde](https://github.com/poole/hyde) but I could not make it work, so I searched for the GitHub Pages compatible themes. The following ones are the most remarkable I found:
- [**Hydejack**](https://github.com/eliocamp/hydejack) - One of the best themes, too bad some features are limited for the premium version and developments stop in February 2022.
- [**Just The Docs**](https://github.com/just-the-docs/just-the-docs]) - Easy to configure and update, probably the best for documentation-oriented websites.
- [**TeXt**](https://github.com/kitian616/jekyll-TeXt-theme) - Another beautiful theme with an amazing design, but developments stop in February 2020.
- [**Minimal Mistakes**](https://github.com/mmistakes/minimal-mistakes) - Still maintained, with a lot of stars and contributors, and a simple yet effective design.

For what I need, **Minimal Mistakes** is a good choice.

---

## // TODO:

I should probably pick a profile photo...
