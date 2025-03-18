$(shell mkdir -p _bin/)
export GOBIN := $(CURDIR)/_bin/

ifneq (,$(wildcard .env.mk))
  include .env.mk
endif
ifneq (,$(wildcard .env))
  include .env
endif

include _makefiles/go-build.mk
include _makefiles/go.mk
include _makefiles/protolint.mk
include _makefiles/scanoss.mk
include _makefiles/shellcheck.mk
include _makefiles/shfmt.mk
include _makefiles/trivy.mk
include _makefiles/util.mk
