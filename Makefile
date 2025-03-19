$(shell mkdir -p _bin/)
export GOBIN := $(CURDIR)/_bin/

ifneq (,$(wildcard .env.mk))
  include .env.mk
endif
ifneq (,$(wildcard .env))
  include .env
endif

include _makefiles/buf.mk
include _makefiles/cspell.mk
include _makefiles/go-build.mk
include _makefiles/go-licenses.mk
include _makefiles/go-test.mk
include _makefiles/go.mk
include _makefiles/goda.mk
include _makefiles/golangci-lint.mk
include _makefiles/govulncheck.mk
include _makefiles/markdownlint.mk
include _makefiles/prettier.mk
include _makefiles/protolint.mk
include _makefiles/scanoss.mk
include _makefiles/shellcheck.mk
include _makefiles/shfmt.mk
include _makefiles/trivy.mk
include _makefiles/util.mk


LOCAL_CHECKS += cspell-run
LOCAL_CHECKS += golangci-lint-run
LOCAL_CHECKS += markdownlint-run
LOCAL_CHECKS += prettier-run
LOCAL_CHECKS += protolint-run
LOCAL_CHECKS += scanoss-run
LOCAL_CHECKS += shellcheck-run
LOCAL_CHECKS += shfmt-run
LOCAL_CHECKS += shfmt-run

.PHONY: local-check
local-check: $(LOCAL_CHECKS)

.PHONY: local-format
local-format:
	$(MAKE) go-fmt ARGS="-w"
	$(MAKE) prettier-run ARGS="--write"
