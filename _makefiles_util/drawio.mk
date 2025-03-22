################################################################################
define drawio.mk
REQUIREMENTS:
  - drawio : `drawio` command must be available.

TARGETS:
  - drawio-help : show help message.
  - drawio-jpg  : convert *.drawio to *.jpg.
  - drawio-png  : convert *.drawio to *.png.
  - drawio-svg  : convert *.drawio to *.svg.
  - drawio-pdf  : convert *.drawio to *.pdf.

VARIABLES [default value]:
  - DRAWIO_CMD        : drawio command. [drawio]
  - DRAWIO_TARGET     : target files. [all *.drawio in docs/]
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
  - Web       : https://app.diagrams.net/
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
DRAWIO_TARGET ?= $(shell find ./docs/ -type f -name '*.drawio' 2>/dev/null)
DRAWIO_OPTION_JPG ?= --quality 100
DRAWIO_OPTION_PNG ?= --transparent
DRAWIO_OPTION_SVG ?=
DRAWIO_OPTION_PDF ?= --crop


# drawio-jpg export *.drawio as jpg image.
# Examples:
#   - make drawio-jpg
#   - make drawio-jpg ARGS=""
#   - make drawio-jpg DRAWIO_TARGET="./foo/*.drawio"
.PHONY: drawio-jpg
drawio-jpg: $(subst .drawio,.jpg,$(DRAWIO_TARGET))
%.jpg: %.drawio
	$(DRAWIO_CMD) --export --format jpg $(ARGS) $(DRAWIO_OPTION_JPG) $^


# drawio-png export *.drawio as png image.
# Examples:
#   - make drawio-png
#   - make drawio-png ARGS=""
#   - make drawio-png DRAWIO_TARGET="./foo/*.drawio"
.PHONY: drawio-png
drawio-png: $(subst .drawio,.png,$(DRAWIO_TARGET))
%.png: %.drawio
	$(DRAWIO_CMD) --export --format png $(ARGS) $(DRAWIO_OPTION_PNG) $^


# drawio-svg export *.drawio as svg image.
# Examples:
#   - make drawio-svg
#   - make drawio-svg ARGS=""
#   - make drawio-svg DRAWIO_TARGET="./foo/*.drawio"
.PHONY: drawio-svg
drawio-svg: $(subst .drawio,.svg,$(DRAWIO_TARGET))
%.svg: %.drawio
	$(DRAWIO_CMD) --export --format svg $(ARGS) $(DRAWIO_OPTION_SVG) $^


# drawio-pdf export *.drawio as pdf image.
# Examples:
#   - make drawio-pdf
#   - make drawio-pdf ARGS=""
#   - make drawio-pdf DRAWIO_TARGET="./foo/*.drawio"
.PHONY: drawio-pdf
drawio-pdf: $(subst .drawio,.pdf,$(DRAWIO_TARGET))
%.pdf: %.drawio
	$(DRAWIO_CMD) --export --format pdf $(ARGS) $(DRAWIO_OPTION_PDF) $^
