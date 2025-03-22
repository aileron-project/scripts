################################################################################
define diagrams.mk
REQUIREMENTS:
  - python3 : `python3` command must be available.

TARGETS:
  - diagrams-help : show help message.
  - diagrams      : convert *.py into images.

VARIABLES [default value]:
  - PYTHON_CMD      : python command. [python3]
  - DIAGRAMS_TARGET : target files. [all *.py in docs/]
  - DIAGRAMS_OPTION : diagrams command line option for jpg. [--quality 100]

REFERENCES:
  - https://diagrams.mingrammer.com/
  - https://github.com/mingrammer/diagrams

IDE INTEGRATIONS:
  - none

PROJECT STRUCTURE:
  /                       |-- Project
  ├─ scripts/             |-- Git submodule
  │  └─ _makefiles_util/  |
  │     └─ diagrams.mk    |
  └─ Makefile             |-- include scripts/_makefiles_util/diagrams.mk
endef
#------------------------------------------------------------------------------#
.PHONY: diagrams-help
diagrams-help:
	$(info $(diagrams.mk))
	@echo ""
################################################################################


PYTHON_CMD ?= python3
DIAGRAMS_TARGET ?= $(shell find ./docs/ -type f -name '*.py' 2>/dev/null)
DIAGRAMS_OPTION ?=


# diagrams export *.py.
# Examples:
#   - make diagrams
#   - make diagrams ARGS=""
#   - make diagrams DIAGRAMS_TARGET="./foo/*.py"
.PHONY: diagrams
diagrams: $(DIAGRAMS_TARGET)

.PHONY: $(DIAGRAMS_TARGET)
$(DIAGRAMS_TARGET):
	$(PYTHON_CMD) $(ARGS) $(DIAGRAMS_OPTION) $@
