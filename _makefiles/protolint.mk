################################################################################
define protolint.mk
REQUIREMENTS:
  - protolint : `protolint` command must be available.
  - go        : `go` command must be available for `protolint-install`.

TARGETS:
  - <TARGET>-usage    : show the <TARGET> usage.
  - protolint-help    : show help message.
  - protolint         : run protolint command with given args.
  - protolint-install : install protolint using `go install`.
  - protolint-run     : run protolint.

VARIABLES [default value]:
  - GO_CMD            : go command used in protolint-install. [go]
  - PROTOLINT_CMD     : protolint command. [$$(GOBIN)protolint]
  - PROTOLINT_VERSION : protolint version to install. [latest]
  - PROTOLINT_TARGET  : target of lint. [./]
  - PROTOLINT_OPTION  : protolint command line option. []

REFERENCES:
  - https://github.com/yoheimuta/protolint
  - https://github.com/yoheimuta/protolint/blob/master/_example/config/.protolint.yaml

IDE INTEGRATIONS:
  - VSCode    : https://marketplace.visualstudio.com/items?itemName=Plex.vscode-protolint
  - JetBrains : https://plugins.jetbrains.com/plugin/12641-protocol-buffer-linter
  - Vim       : https://github.com/yoheimuta/vim-protolint
  - Others?   : https://github.com/yoheimuta/protolint?tab=readme-ov-file#editor-integration

PROJECT STRUCTURE:
  /                      |-- Project
  ├─ scripts/            |-- Git submodule
  │  └─ _makefiles/      |
  │     └─ protolint.mk  |
  ├─ .protolint.yaml     |-- Config file
  └─ Makefile            |-- include scripts/_makefiles/protolint.mk
endef
#------------------------------------------------------------------------------#
.PHONY: protolint-help
protolint-help:
  $(info $(protolint.mk))
  @echo ""
################################################################################


GO_CMD ?= go
PROTOLINT_CMD ?= $(GOBIN)protolint
PROTOLINT_VERSION ?= latest
PROTOLINT_TARGET ?= ./
PROTOLINT_OPTION ?=


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: protolint-install-usage
protolint-install-usage:
  # Usage : make protolint-install ARGS=""
  # Exec  : $$(GO_CMD) install $$(ARGS) "github.com/yoheimuta/protolint/cmd/protolint@$$(PROTOLINT_VERSION)"
  # Desc  : Install protolint using `go install`.
  # Examples:
  #   - make protolint-install
  #   - make protolint-install ARGS="-tags netgo"
  #   - make protolint-install PROTOLINT_VERSION="main"

.PHONY: protolint-install
protolint-install:
ifeq ("protolint-install","$(MAKECMDGOALS)")
  $(GO_CMD) install $(ARGS) "github.com/yoheimuta/protolint/cmd/protolint@$(PROTOLINT_VERSION)"
else
ifeq (,$(shell which $(PROTOLINT_CMD) 2>/dev/null))
  $(GO_CMD) install $(ARGS) "github.com/yoheimuta/protolint/cmd/protolint@$(PROTOLINT_VERSION)"
endif
endif
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: protolint-usage
protolint-usage:
  # Usage : make protolint ARGS=""
  # Exec  : $$(PROTOLINT_CMD) $$(ARGS)
  # Desc  : Run protolint with given arguments.
  # Examples:
  #   - make protolint ARGS="--help"

.PHONY: protolint
protolint: protolint-install
  $(PROTOLINT_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: protolint-run-usage
protolint-run-usage:
  # Usage : make protolint-run ARGS=""
  # Exec  : $$(PROTOLINT_CMD) $$(ARGS) $$(PROTOLINT_OPTION) $$(PROTOLINT_TARGET)
  # Desc  : Run protolint for the specified targets.
  # Examples:
  #   - make protolint-run
  #   - make protolint-run ARGS=""

.PHONY: protolint-run
protolint-run: protolint-install
  $(PROTOLINT_CMD) $(ARGS) $(PROTOLINT_OPTION) $(PROTOLINT_TARGET)
#______________________________________________________________________________#
