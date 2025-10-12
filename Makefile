##
# thisago's blog
#
# @file
# @version 0.1

NPX := npx
NPM := npm
EMACS := emacs
WATCHEXEC := watchexec

BATCH := $(EMACS) -Q --script

OUT_DIR = ./public

.PHONY: all
all: publish

.PHONY: setup
setup:
	$(NPM) i

.PHONY: clean
clean:
	test -d $(OUT_DIR) && \
	rm -r $(OUT_DIR) || true

.PHONY: publish
publish:
	$(BATCH) publish.el

.PHONY: dev
dev:
	$(WATCHEXEC) -e el,org,sass,html,css -r make clean publish serve

.PHONY: serve
serve:
	$(NPX) serve ./public


# end
