export ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = CommCenter

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CCPatch13

CCPatch13_FILES = Tweak.xm
CCPatch13_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
