ARCHS = arm64
TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MenuDemo

MenuDemo_FILES = Tweak.xm MenuView.m
MenuDemo_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
