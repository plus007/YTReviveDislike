ARCHS = arm64 arm64e armv7 armv7s
THEOS_DEVICE_IP = 192.168.0.34
TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = YouTube

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = YTReviveDislike

ReviveDislike_FILES = Tweak.xm YouTubeDataAPI.xm
ReviveDislike_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
