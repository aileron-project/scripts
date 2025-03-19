################################################################################
define goda.mk
REQUIREMENTS:
  - dot  : `dot` command (graphviz) must be available.
  - goda : `goda` command must be available.
  - go   : `go` command must be available for `goda-install`.

TARGETS:
  - <TARGET>-usage : show the <TARGET> usage.
  - goda-help      : show help message.
  - goda-install   : install goda.
  - goda           : run goda command with given args.
  - goda-run       : check licenses and generate licenses file.

VARIABLES [default value]:
  - GO_CMD       : go command used in goda-install. [go]
  - GODA_CMD     : goda command. [$$(GOBIN)goda]
  - GODA_VERSION : goda version to install. [latest]
  - GODA_TARGET  : target to generate graph. [./...]
  - GODA_OUTPUT  : graph output path. [_output/dependency-graph.ext]
  - GODA_OPTION  : goda command line option. []
  - DOT_CMD      : dot (graphviz) command. [dot]
  - DOT_OPTION   : dot command line option. [-Gdpi=250]

REFERENCES:
  - https://github.com/loov/goda
  - https://graphviz.org/
  - https://dreampuf.github.io/GraphvizOnline/
  - https://www.devtoolsdaily.com/graphviz/

IDE INTEGRATIONS:
  - none

PROJECT STRUCTURE:
  /                           |-- Go Project
  ├─ _output/                 |
  │  ├─ dependency-graph.dot  |-- Default dependency graph output file
  │  ├─ dependency-graph.svg  |-- Default dependency graph output file
  │  ├─ dependency-graph.png  |-- Default dependency graph output file
  │  └─ dependency-graph.jpg  |-- Default dependency graph output file
  ├─ scripts/                 |-- Git submodule
  │  └─ _makefiles/           |
  │     └─ goda.mk            |
  ├─ Makefile                 |-- include scripts/_makefiles/goda.mk
  ├─ go.mod                   |
  └─ go.sum                   |
endef
#------------------------------------------------------------------------------#
.PHONY: goda-help
goda-help:
	$(info $(goda.mk))
	@echo ""
################################################################################


GO_CMD ?= go
GODA_CMD ?= $(GOBIN)goda
GODA_VERSION ?= latest
GODA_TARGET ?= ./...
GODA_OUTPUT ?= _output/dependency-graph.ext
GODA_OPTION ?= 
DOT_CMD ?= dot
DOT_OPTION ?= -Gdpi=250


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: goda-install-usage
goda-install-usage:
	# Usage : make goda-install ARGS=""
	# Exec  : $$(GO_CMD) install $$(ARGS) "github.com/loov/goda@$$(GODA_VERSION)"
	# Desc  : Install goda using `go install`.
	# Examples:
	#   - make goda-install
	#   - make goda-install ARGS="-tags netgo"
	#   - make goda-install GODA_VERSION="main"

.PHONY: goda-install
goda-install:
ifeq ("goda-install","$(MAKECMDGOALS)")
	$(GO_CMD) install $(ARGS) "github.com/loov/goda@$(GODA_VERSION)"
else
ifeq (,$(shell which $(GODA_CMD) 2>/dev/null))
	$(GO_CMD) install $(ARGS) "github.com/loov/goda@$(GODA_VERSION)"
endif
endif
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: goda-usage
goda-usage:
	# Usage : make goda ARGS=""
	# Exec  : $$(GODA_CMD) $$(ARGS)
	# Desc  : Run goda with given arguments.
	# Examples:
	#   - make goda ARGS="--help"

.PHONY: goda
goda: goda-install
	$(GODA_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: goda-run-usage
goda-run-usage:
	# Usage : make goda-run ARGS=""
	# Exec  : $$(GODA_CMD) graph $$(ARGS) $$(GODA_OPTION) $$(GODA_TARGET) > $$(basename $$(GODA_OUTPUT)).dot
	#         cat $$(basename $$(GODA_OUTPUT)).dot | $$(DOT_CMD) -Tsvg $$(DOT_OPTION) -o $$(basename $$(GODA_OUTPUT)).svg
	#         cat $$(basename $$(GODA_OUTPUT)).dot | $$(DOT_CMD) -Tpng $$(DOT_OPTION) -o $$(basename $$(GODA_OUTPUT)).png
	#         cat $$(basename $$(GODA_OUTPUT)).dot | $$(DOT_CMD) -Tjpg $$(DOT_OPTION) -o $$(basename $$(GODA_OUTPUT)).jpg
	# Desc  : Generate dependency graph.
	# Examples:
	#   - make goda-run
	#   - make goda-run ARGS=""

.PHONY: goda-run
goda-run: goda-install
	$(GODA_CMD) graph $(ARGS) $(GODA_OPTION) $(GODA_TARGET) > $(basename $(GODA_OUTPUT)).dot
	cat $(basename $(GODA_OUTPUT)).dot | $(DOT_CMD) -Tsvg $(DOT_OPTION) -o $(basename $(GODA_OUTPUT)).svg
	cat $(basename $(GODA_OUTPUT)).dot | $(DOT_CMD) -Tpng $(DOT_OPTION) -o $(basename $(GODA_OUTPUT)).png
	cat $(basename $(GODA_OUTPUT)).dot | $(DOT_CMD) -Tjpg $(DOT_OPTION) -o $(basename $(GODA_OUTPUT)).jpg
#______________________________________________________________________________#
