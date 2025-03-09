#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from sm7250-common
include device/motorola/sm7250-common/BoardConfigCommon.mk

DEVICE_PATH := device/motorola/kiev

# Audio
AUDIO_FEATURE_ENABLED_A2DP_OFFLOAD := true
AUDIO_FEATURE_ENABLED_AHAL_EXT := false

# Audio
AUDIO_FEATURE_ENABLED_EXT_AMPLIFIER := true
AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT := true
BOARD_SUPPORTS_OPENSOURCE_STHAL := true

# Display
TARGET_SCREEN_DENSITY := 420

# HIDL
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml

# ODM
ODM_MANIFEST_SKUS := \
    dn \
    n \
    np

ODM_MANIFEST_DN_FILES := $(DEVICE_PATH)/configs/sku/manifest_dn.xml
ODM_MANIFEST_N_FILES := $(DEVICE_PATH)/configs/sku/manifest_n.xml
ODM_MANIFEST_NP_FILES := $(DEVICE_PATH)/configs/sku/manifest_np.xml

# Partitions
BOARD_DTBOIMG_PARTITION_SIZE := 8388608

# Properties
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Copy to recovery
BOARD_RECOVERY_KERNEL_MODULES_LOAD := \
    utags \
    mmi_annotate \
    mmi_info \
    tzlog_dump \
    mmi_sys_temp \
    qpnp-power-on-mmi \
    wl2864c \
    qpnp-smbcharger-mmi \
    mcDrvModule \
    sensors_class \
    mmi_relay \
    sx933x_sar \
    touchscreen_mmi \
    focaltech_0flash_mmi

RECOVERY_KERNEL_MODULES := $(addsuffix .ko,$(BOARD_RECOVERY_KERNEL_MODULES_LOAD))

# Security
VENDOR_SECURITY_PATCH := 2023-03-01

# inherit from the proprietary version
include vendor/motorola/kiev/BoardConfigVendor.mk
