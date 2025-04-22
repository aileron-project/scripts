################################################################################
define pkgsite.mk
REQUIREMENTS:
  - pkgsite : `pkgsite` command must be available.
  - go      : `go` command must be available for `pkgsite-install`.

TARGETS:
  - pkgsite-help    : show help message.
  - pkgsite-install : install pkgsite using `go install`.
  - pkgsite-open    : open package site.

VARIABLES [default value]:
  - GO_CMD          : go command used in pkgsite-install. [go]
  - PKGSITE_CMD     : pkgsite command. [$$(GOBIN)pkgsite]
  - PKGSITE_VERSION : pkgsite version to install. [latest]
  - PKGSITE_TARGET  : target directory to serve. [./]
  - PKGSITE_OPTION  : pkgsite command line options. []

REFERENCES:
  - https://pkg.go.dev/golang.org/x
  - https://pkg.go.dev/golang.org/x/pkgsite
  - https://pkg.go.dev/golang.org/x/pkgsite/cmd/pkgsite
  - https://pkg.go.dev/golang.org/x/tools/cmd/godoc

IDE INTEGRATIONS:
  - none

PROJECT STRUCTURE:
  /                       |-- Go Project
  ├─ scripts/             |-- Git submodule
  │  └─ _makefiles_util/  |
  │     └─ pkgsite.mk     |
  ├─ Makefile             |-- include scripts/_makefiles/pkgsite.mk
  ├─ go.mod               |
  └─ go.sum               |
endef
#------------------------------------------------------------------------------#
.PHONY: pkgsite-help
pkgsite-help:
	$(info $(pkgsite.mk))
	@echo ""
################################################################################


GO_CMD ?= go
PKGSITE_CMD ?= $(GOBIN)pkgsite
PKGSITE_VERSION ?= latest
PKGSITE_TARGET ?= ./
PKGSITE_OPTION ?=


# pkgsite-install installs pkgsite tool.
# Examples:
#   - make pkgsite-install
#   - make pkgsite-install ARGS="-tags netgo"
#   - make pkgsite-install PKGSITE_VERSION="main"
.PHONY: pkgsite-install
pkgsite-install:
ifeq ("pkgsite-install","$(MAKECMDGOALS)")
	$(GO_CMD) install $(ARGS) "golang.org/x/pkgsite/cmd/pkgsite@$(PKGSITE_VERSION)"
	$(GO_CMD) mod tidy
else
ifeq (,$(shell which $(PKGSITE_CMD) 2>/dev/null))
	$(GO_CMD) install $(ARGS) "golang.org/x/pkgsite/cmd/pkgsite@$(PKGSITE_VERSION)"
	$(GO_CMD) mod tidy
endif
endif

# pkgsite-open opens go package site locally.
# Examples:
#   - make pkgsite-open
#   - make pkgsite-open ARGS="-http localhost:8081"
.PHONY: pkgsite-open
pkgsite-open: pkgsite-install
pkgsite-open:
	$(PKGSITE_CMD) $(PKGSITE_OPTION) $(ARGS) -open $(PKGSITE_TARGET)
