ifeq ($(RTE_SDK),)
$(error "Please define RTE_SDK environment variable")
endif

# Default target, can be overriden by command line or environment
RTE_TARGET ?= x86_64-native-linuxapp-gcc

include $(RTE_SDK)/mk/rte.vars.mk

# binary name
APP = nat

# all source are stored in SRCS-y
SRCS-y := main.c lib/expirator.c lib/flow.c lib/flow-log.c lib/my-time.c lib/containers/batcher.c lib/containers/double-chain.c lib/containers/double-chain-impl.c lib/containers/double-map.c lib/containers/map.c

CFLAGS += -O3
CFLAGS += $(WERROR_FLAGS)
CFLAGS += -I$(SRCDIR)

include $(RTE_SDK)/mk/rte.extapp.mk
