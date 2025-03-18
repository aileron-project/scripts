$(shell mkdir -p _bin/)
export GOBIN := $(CURDIR)/_bin/

ifneq (,$(wildcard .env.mk))
  include .env.mk
endif
ifneq (,$(wildcard .env))
  include .env
endif

include _makefiles/trivy.mk
include _makefiles/util.mk
