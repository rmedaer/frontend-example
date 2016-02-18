#
#
#

.PHONY: all build deps clean reallyclean

DIST_DIR := dist
SRC_DIR := src
LIB_DIR := lib

JS_APP = $(DIST_DIR)/app.js
CSS_APP = $(DIST_DIR)/app.css

DEPS = $(shell bower list --json --paths | jq -r '(.[] | select(type == "string")), (.[] | .[]?)' | tac)
DEPS += $(shell find $(SRC_DIR) -type f)

DIST_FILES = $(DEPS:%=$(DIST_DIR)/%)

all: build

build: $(DIST_DIR)/index.html

deps: $(LIB_DIR)
	wiredep --includeSelf -b bower.json -s index.html

$(DIST_DIR)/%.js: %.js
	install -D $< $@
	ng-annotate -a --single_quotes $< > $@

$(DIST_DIR)/%.css: %.css
	install -D $< $@

$(DIST_DIR)/%.html: %.html
	install -D $< $@

$(DIST_DIR)/bower.json: bower.json
	install -D $< $@
	jq '.main |= ["app.min.js", "app.css"]' $@ | sponge $@
	jq '.dependencies |= []' $@ | sponge $@

$(DIST_DIR)/index.html: index.html bower.json $(DIST_DIR)/bower.json $(DIST_FILES) $(JS_APP) $(CSS_APP)
	install -D $< $@
	(cd $(DIST_DIR) && wiredep --includeSelf -b bower.json -s index.html)

$(CSS_APP): $(filter %.css,$(DIST_FILES))
	cat $(filter %.css,$(DIST_FILES)) > $@

$(JS_APP): $(filter %.js,$(DIST_FILES))
	echo $(filter %.js,$(DIST_FILES))
	uglifyjs \
		--mangle \
		--compress \
		--source-map-root / \
		--source-map-url $(notdir $(basename $@).min.js.map) \
		--source-map $(basename $@).min.js.map \
		--output $(basename $@).min.js \
		$(filter %.js,$(DIST_FILES))

$(LIB_DIR): bower.json
	bower install

clean:
	rm -rf $(DIST_DIR)

reallyclean: clean
	rm -rf $(LIB_DIR)
