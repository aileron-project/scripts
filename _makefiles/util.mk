################################################################################
define util.mk
REQUIREMENTS:
  - none

TARGETS:
  - util-help      : show help message.
  - list-makefiles : list loaded makefiles.
  - list-helps     : list help command for loaded makefiles.
  - helps          : alias to the list-helps.
  - help           : alias to the list-helps.

VARIABLES [default value]:
  - none

REFERENCES:
  - none

IDE INTEGRATION:
  - none

PROJECT STRUCTURE:
  /                  |-- Project
  ├─ scripts/        |-- Git submodule
  │  └─ _makefiles/  |
  │     └─ util.mk   |
  └─ Makefile        |-- include scripts/_makefiles/util.mk
endef
#------------------------------------------------------------------------------#
.PHONY: util-help
util-help:
	$(info $(util.mk))
	@echo ""
################################################################################


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: list-makefiles
list-makefiles:
	@for target in $(MAKEFILE_LIST); do \
	echo "$$target"; \
	done
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: help helps list-helps
help helps list-helps:
	$(info Help commands)
	$(info -------------)
	@for target in $(basename $(notdir $(MAKEFILE_LIST))); do \
	test "$$target" != "Makefile" && echo "make $$target-help"; \
	done
#______________________________________________________________________________#
