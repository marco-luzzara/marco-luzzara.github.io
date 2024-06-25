SHELL=/bin/bash
DOCKER_OPTIONS := --rm
# DOCKER_MOUNT_CACHE := --volume $$PWD/gem-cache:/usr/gem/gems:Z
SITE_FOLDER := docs

.PHONY: create-site serve build clean

serve: build
	docker compose up jekyll-serve

build:
	docker compose run $(DOCKER_OPTIONS) jekyll jekyll build

create-site:
	mkdir -p $(SITE_FOLDER)
	docker compose run $(DOCKER_OPTIONS) jekyll bash -c "jekyll new --skip-bundle ."
	sed -i 's/^gem "jekyll"/# &/' $(SITE_FOLDER)/Gemfile
	sed -i "s|^# gem \"github-pages\"|gem \"github-pages\", \"~> 231\"|" $(SITE_FOLDER)/Gemfile
	echo -e "\n# Custom\ngem \"webrick\", \"~> 1.7\"" >> $(SITE_FOLDER)/Gemfile
	echo "Gemfile.lock" >> $(SITE_FOLDER)/.gitignore
	docker compose run $(DOCKER_OPTIONS) jekyll bundle install
	
clean:
	rm -rf vendor docs

# to test:
# docker run --rm -it -v "$PWD/docs:/srv/jekyll" jekyll/jekyll:4 bash
# try to use a named volume because the cache content is overwritten by the host dir