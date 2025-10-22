SHELL=/bin/bash
SITE_FOLDER := docs

.PHONY: install
install:
	cd ${SITE_FOLDER} && bundle install


.PHONY: run
run: install
	cd ${SITE_FOLDER} && bundle exec jekyll serve
