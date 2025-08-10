THEOS_DEVICE_IP = 192.168.3.22

ifeq ($(THEOS_PACKAGE_SCHEME),rootless)
	ARCHS = arm64 arm64e
	TARGET = iphone:clang:latest:15.0
else
	ARCHS = armv7 armv7s arm64 arm64e
	TARGET = iphone:clang:13.7:8.0
endif

INSTALL_TARGET_PROCESSES = CommCenter
LEAN_AND_MEAN = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CCPatch13

CCPatch13_FILES = Tweak.xm
CCPatch13_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
