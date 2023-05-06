ARCHS = arm64 arm64e armv7 armv7s
TARGET = iphone:clang:latest:8.0
INSTALL_TARGET_PROCESSES = CommCenter
LEAN_AND_MEAN = 1
PREFIX = /Applications/Xcode-11.7.0.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CCPatch13

CCPatch13_FILES = Tweak.xm
CCPatch13_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
