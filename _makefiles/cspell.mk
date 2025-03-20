################################################################################
define cspell.mk
REQUIREMENTS:
  - cspell : `cspell` command must be available.
  - npm    : `npm` command must be available for `cspell-install`.

TARGETS:
  - <TARGET>-usage : show the <TARGET> usage.
  - cspell-help    : show help message.
  - cspell-install : install cspell using `npm -g`.
  - cspell         : run cspell command with given args.
  - cspell-run     : run spell check.

VARIABLES [default value]:
  - CSPELL_CMD     : cspell binary path. [cspell]
  - CSPELL_VERSION : cspell version to install. [latest]
  - CSPELL_TARGET  : target of spell check. [./]
  - CSPELL_OPTION  : cspell lint command line option. [--quiet --words-only --unique]

REFERENCES:
  - https://cspell.org/
  - https://cspell.org/docs/getting-started
  - https://cspell.org/docs/installation/
  - https://github.com/streetsidesoftware/cspell

IDE INTEGRATIONS:
  - VSCode    : https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker
  - JetBrains : https://plugins.jetbrains.com/plugin/20676-cspell-check

PROJECT STRUCTURE:
  /                      |-- Project
  ├─ scripts/            |-- Git submodule
  │  └─ _makefiles/      |
  │     └─ cspell.mk     |
  ├─ .cspell.yaml        |-- Config file
  ├─ .project-words.txt  |-- Allowed words list (must be configured)
  └─ Makefile            |-- include scripts/_makefiles/cspell.mk
endef
#------------------------------------------------------------------------------#
.PHONY: cspell-help
cspell-help:
  $(info $(cspell.mk))
  @echo ""
################################################################################


CSPELL_CMD ?= cspell
CSPELL_VERSION ?= latest
CSPELL_TARGET ?= ./
CSPELL_OPTION ?= --quiet --words-only --unique


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: cspell-install-usage
cspell-install-usage:
  # Usage : make cspell-install ARGS=""
  # Exec  : npm install -g "cspell@$$(CSPELL_VERSION)"
  # Desc  : Install cspell using `npm -g`.
  # Examples:
  #   - make cspell-install
  #   - make cspell-install ARGS=""
  #   - make cspell-install CSPELL_VERSION="next"

.PHONY: cspell-install
cspell-install:
ifeq ("cspell-install","$(MAKECMDGOALS)")
  npm install -g "cspell@$(CSPELL_VERSION)"
else
ifeq (,$(shell which $(CSPELL_CMD) 2>/dev/null))
  npm install -g "cspell@$(CSPELL_VERSION)"
endif
endif
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: cspell-usage
cspell-usage:
  # Usage : make cspell ARGS=""
  # Exec  : $$(CSPELL_CMD) $$(ARGS)
  # Desc  : Run cspell with given arguments.
  # Examples:
  #   - make cspell ARGS="--version"
  #   - make cspell ARGS="--help"

.PHONY: cspell
cspell: cspell-install
  $(CSPELL_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: cspell-run-usage
cspell-run-usage:
  # Usage : make cspell-run ARGS=""
  # Exec  : $$(CSPELL_CMD) lint $$(ARGS) $$(CSPELL_OPTION) $$(CSPELL_TARGET)
  # Desc  : Run spell check.
  # Examples:
  #   - make cspell
  #   - make cspell ARGS=""

.PHONY: cspell-run
cspell-run: cspell-install
  $(CSPELL_CMD) lint $(ARGS) $(CSPELL_OPTION) $(CSPELL_TARGET)
#______________________________________________________________________________#
