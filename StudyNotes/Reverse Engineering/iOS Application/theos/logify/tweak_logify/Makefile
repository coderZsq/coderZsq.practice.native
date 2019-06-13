include $(THEOS)/makefiles/common.mk

TWEAK_NAME = tweak_logify
tweak_logify_FILES = $(wildcard src/*.xm)

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
