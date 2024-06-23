SHELL=/bin/bash
DOCKER_OPTIONS := --rm
# DOCKER_MOUNT_CACHE := --volume $$PWD/gem-cache:/usr/gem/gems:Z
SITE_FOLDER := docs

.PHONY: create-site serve build clean

serve:
	docker compose run $(DOCKER_OPTIONS) jekyll-serve bundle exec jekyll serve --watch --livereload

build:
	docker compose run $(DOCKER_OPTIONS) jekyll-serve bundle exec jekyll build

create-site:
	mkdir -p $(SITE_FOLDER)
	mkdir -p gem-cache/gems gem-cache/cache gem-cache/bundle
	docker compose up -d jekyll
	docker compose exec jekyll bash -c "chown -R jekyll /usr/gem/ && jekyll new --skip-bundle ."
	sed -i 's/^gem "jekyll"/# &/' $(SITE_FOLDER)/Gemfile
	sed -i "s|^# gem \"github-pages\"|gem \"github-pages\", \"~> 231\"|" $(SITE_FOLDER)/Gemfile
	echo -e "\n# Custom\ngem \"webrick\", \"~> 1.7\"" >> $(SITE_FOLDER)/Gemfile
	echo "Gemfile.lock" >> $(SITE_FOLDER)/.gitignore
	docker compose exec jekyll bundle install
	docker compose cp jekyll:/usr/gem/gems/. ./gem-cache/gems
	docker compose cp jekyll:/usr/gem/cache/. ./gem-cache/cache
	docker compose cp jekyll:/usr/local/bundle/. ./gem-cache/bundle
	docker compose down jekyll
	
clean:
	rm -rf gem-cache docs

# to test:
# docker run --rm -it -v "$PWD/docs:/srv/jekyll" jekyll/jekyll:4 bash
# try to use a named volume because the cache content is overwritten by the host dir