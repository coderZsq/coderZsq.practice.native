
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = tweak_sb
tweak_sb_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
