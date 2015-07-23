################################################################################
#
# rtl8723bs SDIO WiFi Driver
#
################################################################################

RTL8723BS_VERSION = $(call qstrip,$(BR2_PACKAGE_RTL8723BS_VERSION))

RTL8723BS_DEPENDENCIES = linux
#RTL8723BS_INSTALL_STAGING = YES
RTL8723BS_LICENSE = GPLv2+

ifeq ($(BR2_PACKAGE_RTL8723BS_CUSTOM_GIT),y)
RTL8723BS_SITE = $(call qstrip,$(BR2_PACKAGE_RTL8723BS_CUSTOM_REPO_URL))
RTL8723BS_SITE_METHOD = git
BR_NO_CHECK_HASH_FOR += $(RTL8723BS_SOURCE)
endif

define RTL8723BS_BUILD_CMDS
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KSRC=$(LINUX_DIR) modules
endef

define RTL8723BS_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KSRC=$(LINUX_DIR) \
		PREFIX=$(TARGET_DIR) modules_install
	$(HOST_DIR)/sbin/depmod -a -b $(TARGET_DIR) $(LINUX_VERSION_PROBED)
endef

$(eval $(generic-package))
