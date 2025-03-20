SHELL := /bin/bash -euo pipefail
################################################################################
define buf.mk
REQUIREMENTS:
  - buf : `buf` command must be available.
  - go  : `go` command must be available for `buf-install`.

TARGETS:
  - <TARGET>-usage : show the <TARGET> usage.
  - buf-help       : show help message.
  - buf-install    : install buf using `go install`.
  - buf            : run buf command with given args.
  - buf-lint       : run buf lint.
  - buf-format     : run buf format.
  - buf-generate   : run buf generate.

VARIABLES [default value]:
  - GO_CMD              : go command used in buf-install. [go]
  - BUF_CMD             : buf command. [$$(GOBIN)buf]
  - BUF_VERSION         : buf version to install. [latest]
  - BUF_LINT_OPTION     : buf lint command line option. []
  - BUF_FORMAT_OPTION   : buf format command line option. [--exit-code --diff]
  - BUF_GENERATE_OPTION : buf generate command line option. [--include-imports]

REFERENCES:
  - https://github.com/bufbuild
  - https://buf.build/docs/

IDE INTEGRATIONS:
  - VSCode    : https://marketplace.visualstudio.com/items?itemName=bufbuild.vscode-buf
  - JetBrains : https://plugins.jetbrains.com/plugin/19147-buf-for-protocol-buffers
  - Vim       : https://github.com/bufbuild/vim-buf
  - Others?   : https://buf.build/docs/cli/editor-integration/

PROJECT STRUCTURE:
  /                  |-- Project
  ├─ scripts/        |-- Git submodule
  │  └─ _makefiles/  |
  │     └─ buf.mk    |
  ├─ Makefile        |-- include scripts/_makefiles/buf.mk
  ├─ buf.yaml        |-- Config file
  ├─ buf.gen.yaml    |-- Config file
  └─ buf.lock        |-- Auto generated file managed by buf
endef
#------------------------------------------------------------------------------#
.PHONY: buf-help
buf-help:
	$(info $(buf.mk))
	@echo ""
################################################################################


GO_CMD ?= go
BUF_CMD ?= $(GOBIN)buf
BUF_VERSION ?= latest
BUF_LINT_OPTION ?= 
BUF_FORMAT_OPTION ?= --exit-code --diff
BUF_GENERATE_OPTION ?= --include-imports


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: buf-install-usage
buf-install-usage:
	# Usage : make buf-install ARGS=""
	# Exec  : $$(GO_CMD) install $$(ARGS) "github.com/bufbuild/buf/cmd/buf@$$(BUF_VERSION)"
	# Desc  : Install buf using `go install`.
	# Examples:
	#   - make buf-install
	#   - make buf-install ARGS="-tags netgo"
	#   - make buf-install BUF_VERSION="main"

.PHONY: buf-install
buf-install:
ifeq ("buf-install","$(MAKECMDGOALS)")
	$(GO_CMD) install $(ARGS) "github.com/bufbuild/buf/cmd/buf@$(BUF_VERSION)"
else
ifeq (,$(shell which $(BUF_CMD) 2>/dev/null))
	$(GO_CMD) install $(ARGS) "github.com/bufbuild/buf/cmd/buf@$(BUF_VERSION)"
endif
endif
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: buf-usage
buf-usage:
	# Usage : make buf ARGS=""
	# Exec  : $$(BUF_CMD) $$(ARGS)
	# Desc  : Run buf with given arguments.
	# Examples:
	#   - make buf ARGS="--version"
	#   - make buf ARGS="--help"

.PHONY: buf
buf: buf-install
	$(BUF_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: buf-lint-usage
buf-lint-usage:
	# Usage : make buf-lint ARGS=""
	# Exec  : $$(BUF_CMD) lint $$(ARGS) $$(BUF_LINT_OPTION)
	# Desc  : Run buf lint.
	# Examples:
	#   - make buf-lint
	#   - make buf-lint ARGS=""

.PHONY: buf-lint
buf-lint: buf-install
	$(BUF_CMD) lint $(ARGS) $(BUF_LINT_OPTION)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: buf-format-usage
buf-format-usage:
	# Usage : make buf-format ARGS=""
	# Exec  : $$(BUF_CMD) format $$(ARGS) $$(BUF_FORMAT_OPTION)
	# Desc  : Run buf format.
	# Examples:
	#   - make buf-format
	#   - make buf-format ARGS="--write"

.PHONY: buf-format
buf-format: buf-install
	$(BUF_CMD) format $(ARGS) $(BUF_FORMAT_OPTION)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: buf-generate-usage
buf-generate-usage:
	# Usage : make buf-generate ARGS=""
	# Exec  : $$(BUF_CMD) generate $$(ARGS) $$(BUF_GENERATE_OPTION)
	# Desc  : Run buf generate.
	# Examples:
	#   - make buf-generate
	#   - make buf-generate ARGS=""

.PHONY: buf-generate
buf-generate: buf-install
	$(BUF_CMD) generate $(ARGS) $(BUF_GENERATE_OPTION)
#______________________________________________________________________________#
