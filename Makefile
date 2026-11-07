THEOS_PACKAGE_SCHEME ?= rootless
export THEOS ?= $(HOME)/theos

TARGET = iphone:clang:latest:18.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = HideBreadcrumbs
HideBreadcrumbs_FILES = Tweak.xm
HideBreadcrumbs_FRAMEWORKS = Foundation
HideBreadcrumbs_CFLAGS = -fobjc-arc -Wall -Wextra -Wno-unused-parameter
HideBreadcrumbs_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk
