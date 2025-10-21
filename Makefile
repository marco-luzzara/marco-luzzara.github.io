SHELL=/bin/bash
SITE_FOLDER := docs2
JEKYLL_PORT ?= 4000

# variables:
# - BUILD_ARGS: arguments to the `jekyll build` commands (e.g. `--verbose`). 
# - THEME_GEM_ID: the remote theme installation parameters for the `gem` command (e.g. for `minima`, it is `"minima", "~> 2.0"`) 
# - THEME_NAME: the remote theme name to use in the _config.yml

.PHONY: install
install:
	cd ${SITE_FOLDER} && bundle install


.PHONY: run
run: install
	cd ${SITE_FOLDER} && bundle exec jekyll serve


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