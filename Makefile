SHELL=/bin/bash
DOCKER_OPTIONS := --rm
# DOCKER_MOUNT_CACHE := --volume $$PWD/gem-cache:/usr/gem/gems:Z
SITE_FOLDER := docs
JEKYLL_PORT ?= 4000

# variables:
# - BUILD_ARGS: arguments to the `jekyll build` commands (e.g. `--verbose`). 
# - THEME_GEM_ID: the remote theme installation parameters for the `gem` command (e.g. for `minima`, it is `"minima", "~> 2.0"`) 
# - THEME_NAME: the remote theme name to use in the _config.yml

.PHONY: create-site build serve stop clean change-theme

serve:
	JEKYLL_PORT=$(JEKYLL_PORT) docker compose up jekyll-serve

build:
	docker compose run $(DOCKER_OPTIONS) jekyll jekyll build $(ARGS)

create-site:
	mkdir -p $(SITE_FOLDER)
	docker compose run $(DOCKER_OPTIONS) jekyll bash -c "jekyll new --skip-bundle ."
	echo "Gemfile.lock" >> $(SITE_FOLDER)/.gitignore
	cp templates/Gemfile $(SITE_FOLDER)/Gemfile
	sed -i 's/{THEME_GEM_ID}/$(subst /,\/,$(THEME_GEM_ID))/' $(SITE_FOLDER)/Gemfile
	cp templates/_config.yml $(SITE_FOLDER)/_config.yml
	sed -i 's/{THEME_NAME}/$(subst /,\/,$(THEME_NAME))/' $(SITE_FOLDER)/_config.yml
	docker compose run $(DOCKER_OPTIONS) jekyll bundle install

change-theme:
	cp templates/Gemfile $(SITE_FOLDER)/Gemfile
	sed -i 's/{THEME_GEM_ID}/$(subst /,\/,$(THEME_GEM_ID))/' $(SITE_FOLDER)/Gemfile
	cp templates/_config.yml $(SITE_FOLDER)/_config.yml
	sed -i 's/{THEME_NAME}/$(subst /,\/,$(THEME_NAME))/' $(SITE_FOLDER)/_config.yml
	docker compose run $(DOCKER_OPTIONS) jekyll bundle install
	
stop:
	docker compose down

# to test:
# docker run --rm -it -v "$PWD/docs:/srv/jekyll" jekyll/jekyll:4 bash
# try to use a named volume because the cache content is overwritten by the host dir