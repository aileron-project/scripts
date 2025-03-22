################################################################################
define graphviz.mk
REQUIREMENTS:
  - graphviz : `graphviz` command must be available.

TARGETS:
  - graphviz-help : show help message.
  - graphviz-jpg  : convert *.graphviz to *.jpg.
  - graphviz-png  : convert *.graphviz to *.png.
  - graphviz-svg  : convert *.graphviz to *.svg.
  - graphviz-pdf  : convert *.graphviz to *.pdf.

VARIABLES [default value]:
  - DOT_CMD             : dot (graphviz) command. [dot]
  - GRAPHVIZ_TARGET     : target files. [all *.dot in docs/]
  - GRAPHVIZ_OPTION_JPG : dot command line option for jpg. [-Gdpi=150]
  - GRAPHVIZ_OPTION_PNG : dot command line option for png. [-Gdpi=150]
  - GRAPHVIZ_OPTION_SVG : dot command line option for svg. []
  - GRAPHVIZ_OPTION_PDF : dot command line option for pdf. []

REFERENCES:
  - https://graphviz.org/
  - https://dreampuf.github.io/GraphvizOnline/
  - https://www.devtoolsdaily.com/graphviz/

IDE INTEGRATIONS:
  - VSCode    : https://marketplace.visualstudio.com/items?itemName=EFanZh.graphviz-preview
  - VSCode    : https://marketplace.visualstudio.com/items?itemName=tintinweb.graphviz-interactive-preview
  - JetBrains : https://plugins.jetbrains.com/plugin/10312-dot-language
  - Vim       : https://github.com/liuchengxu/graphviz.vim
  - Web       : https://dreampuf.github.io/GraphvizOnline/
  - Web       : https://magjac.com/graphviz-visual-editor/
  - Others?   : https://graphviz.org/resources/

PROJECT STRUCTURE:
  /                       |-- Project
  ├─ scripts/             |-- Git submodule
  │  └─ _makefiles_util/  |
  │     └─ graphviz.mk    |
  └─ Makefile             |-- include scripts/_makefiles_util/graphviz.mk
endef
#------------------------------------------------------------------------------#
.PHONY: graphviz-help
graphviz-help:
	$(info $(graphviz.mk))
	@echo ""
################################################################################


DOT_CMD ?= graphviz
GRAPHVIZ_TARGET ?= $(shell find ./docs/ -type f -name '*.dot' 2>/dev/null)
GRAPHVIZ_OPTION_JPG ?= -Gdpi=150
GRAPHVIZ_OPTION_PNG ?= -Gdpi=150
GRAPHVIZ_OPTION_SVG ?=
GRAPHVIZ_OPTION_PDF ?=


# graphviz-jpg export *.dot as jpg image.
# Examples:
#   - make graphviz-jpg
#   - make graphviz-jpg ARGS=""
#   - make graphviz-jpg GRAPHVIZ_TARGET="./foo/*.dot"
.PHONY: graphviz-jpg
graphviz-jpg: $(subst .dot,.jpg,$(GRAPHVIZ_TARGET))
%.jpg: %.dot
	cat $^ | $(DOT_CMD) -Tjpg -o $@ $(ARGS) $(GRAPHVIZ_OPTION_JPG)


# graphviz-png export *.dot as png image.
# Examples:
#   - make graphviz-png
#   - make graphviz-png ARGS=""
#   - make graphviz-png GRAPHVIZ_TARGET="./foo/*.dot"
.PHONY: graphviz-png
graphviz-png: $(subst .dot,.png,$(GRAPHVIZ_TARGET))
%.png: %.dot
	cat $^ | $(DOT_CMD) -Tpng -o $@ $(ARGS) $(GRAPHVIZ_OPTION_PNG)


# graphviz-svg export *.dot as svg image.
# Examples:
#   - make graphviz-svg
#   - make graphviz-svg ARGS=""
#   - make graphviz-svg GRAPHVIZ_TARGET="./foo/*.dot"
.PHONY: graphviz-svg
graphviz-svg: $(subst .dot,.svg,$(GRAPHVIZ_TARGET))
%.svg: %.dot
	cat $^ | $(DOT_CMD) -Tsvg -o $@ $(ARGS) $(GRAPHVIZ_OPTION_SVG)


# graphviz-pdf export *.dot as pdf image.
# Examples:
#   - make graphviz-pdf
#   - make graphviz-pdf ARGS=""
#   - make graphviz-pdf GRAPHVIZ_TARGET="./foo/*.dot"
.PHONY: graphviz-pdf
graphviz-pdf: $(subst .dot,.pdf,$(GRAPHVIZ_TARGET))
%.pdf: %.dot
	cat $^ | $(DOT_CMD) -Tpdf -o $@ $(ARGS) $(GRAPHVIZ_OPTION_PDF)
