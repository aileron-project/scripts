################################################################################
define drawio.mk
REQUIREMENTS:
  - drawio : `drawio` command must be available.

TARGETS:
  - <TARGET>-usage : show the <TARGET> usage.
  - drawio-help    : show help message.
  - drawio         : run drawio command with given args.
  - drawio-jpg     : convert *.drawio to *.jpg.
  - drawio-png     : convert *.drawio to *.png.
  - drawio-svg     : convert *.drawio to *.svg.

VARIABLES [default value]:
  - DRAWIO_CMD        : drawio binary path. (Default "drawio")
  - DRAWIO_TARGET     : target files. (Default is all *.drawio files)
  - DRAWIO_OPTION_JPG : drawio command line option for jpg. [--quality 100]
  - DRAWIO_OPTION_PNG : drawio command line option for png. [--transparent]
  - DRAWIO_OPTION_SVG : drawio command line option for svg. []
  - DRAWIO_OPTION_PDF : drawio command line option for pdf. [--crop]

REFERENCES:
  - https://github.com/jgraph/drawio-desktop
  - https://www.drawio.com/

IDE INTEGRATIONS:
  - VSCode    : https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio
  - JetBrains : https://plugins.jetbrains.com/plugin/15635-diagrams-net-integration
  - Others?   : https://www.drawio.com/integrations

PROJECT STRUCTURE:
  /                       |-- Project
  ├─ scripts/             |-- Git submodule
  │  └─ _makefiles_util/  |
  │     └─ drawio.mk      |
  └─ Makefile             |-- include scripts/_makefiles_util/drawio.mk
endef
#------------------------------------------------------------------------------#
.PHONY: drawio-help
drawio-help:
	$(info $(drawio.mk))
	@echo ""
################################################################################


DRAWIO_CMD ?= drawio
DRAWIO_TARGET ?= $(shell find . -type f -name '*.drawio' 2>/dev/null)
DRAWIO_OPTION_JPG ?= --quality 100
DRAWIO_OPTION_PNG ?= --transparent
DRAWIO_OPTION_SVG ?=
DRAWIO_OPTION_PDF ?= --crop


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: nfpm-usage
nfpm-usage:
	# Usage : make drawio ARGS=""
	# Exec  : $$(DRAWIO_CMD) $$(ARGS)
	# Desc  : Run drawio with given arguments.
	# Examples:
	#   - make drawio ARGS="--version"
	#   - make drawio ARGS="--help"

.PHONY: drawio
drawio:
	$(DRAWIO_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: drawio-jpg-usage
drawio-jpg-usage:
	# Usage : make drawio-jpg ARGS=""
	# Exec  : $$(DRAWIO_CMD) --export --format jpg $$(ARGS) $$(DRAWIO_OPTION_JPG) $$target
	# Desc  : Export drawio as jpg.
	# Examples:
	#   - make drawio-jpg
	#   - make drawio-jpg ARGS=""
	#   - make drawio-jpg DRAWIO_TARGET="./foo/*.drawio"

.PHONY: drawio-jpg
drawio-jpg:
	@for target in $(DRAWIO_TARGET); do \
	$(DRAWIO_CMD) --export --format jpg $(ARGS) $(DRAWIO_OPTION_JPG) $$target; \
	done
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: drawio-png-usage
drawio-png-usage:
	# Usage : make drawio-png ARGS=""
	# Exec  : $$(DRAWIO_CMD) --export --format png $$(ARGS) $$(DRAWIO_OPTION_PNG) $$target
	# Desc  : Export drawio as png.
	# Examples:
	#   - make drawio-png
	#   - make drawio-png ARGS=""
	#   - make drawio-png DRAWIO_TARGET="./foo/*.drawio"

.PHONY: drawio-png
drawio-png:
	@for target in $(DRAWIO_TARGET); do \
	$(DRAWIO_CMD) --export --format png $(ARGS) $(DRAWIO_OPTION_PNG) $$target; \
	done
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: drawio-svg-usage
drawio-svg-usage:
	# Usage : make drawio-svg ARGS=""
	# Exec  : $$(DRAWIO_CMD) --export --format svg $$(ARGS) $$(DRAWIO_OPTION_SVG) $$target
	# Desc  : Export drawio as svg.
	# Examples:
	#   - make drawio-svg
	#   - make drawio-svg ARGS=""
	#   - make drawio-svg DRAWIO_TARGET="./foo/*.drawio"

.PHONY: drawio-svg
drawio-svg:
	@for target in $(DRAWIO_TARGET); do \
	$(DRAWIO_CMD) --export --format svg $(ARGS) $(DRAWIO_OPTION_SVG) $$target; \
	done
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: drawio-pdf-usage
drawio-pdf-usage:
	# Usage : make drawio-pdf ARGS=""
	# Exec  : $$(DRAWIO_CMD) --export --format pdf $$(ARGS) $$(DRAWIO_OPTION_PDF) $$target
	# Desc  : Export drawio as pdf.
	# Examples:
	#   - make drawio-pdf
	#   - make drawio-pdf ARGS=""
	#   - make drawio-pdf DRAWIO_TARGET="./foo/*.drawio"

.PHONY: drawio-pdf
drawio-pdf:
	@for target in $(DRAWIO_TARGET); do \
	$(DRAWIO_CMD) --export --format pdf $(ARGS) $(DRAWIO_OPTION_PDF) $$target; \
	done
#______________________________________________________________________________#
