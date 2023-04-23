#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from sm7250-common
$(call inherit-product, device/motorola/sm7250-common/common.mk)

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-lineage

PRODUCT_ENFORCE_RRO_TARGETS := *

PRODUCT_PACKAGES += \
    NoCutoutOverlay \
    AvoidAppsInCutoutOverlay

# SKU specific RROs
PRODUCT_PACKAGES += \
    LineageSystemUIXT2113_3

# Audio
PRODUCT_PACKAGES += \
    android.hardware.soundtrigger@2.3-impl \
    firmware_aw_cali.bin_symlink

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/audio/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    $(LOCAL_PATH)/audio/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml \
    $(LOCAL_PATH)/audio/sound_trigger_mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_mixer_paths.xml \
    $(LOCAL_PATH)/audio/sound_trigger_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_platform_info.xml

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml

# Barometer
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sku/unavail.android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_dn/unavail.android.hardware.sensor.barometer.xml \
    $(LOCAL_PATH)/configs/sku/unavail.android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_ODM)/etc/sku_n/unavail.android.hardware.sensor.barometer.xml

# Fingerprint
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/idc/uinput-egis.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/uinput-egis.idc \
    $(LOCAL_PATH)/configs/keylayout/uinput-egis.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/uinput-egis.kl

# FM
PRODUCT_PACKAGES += \
    FM2

# Init
PRODUCT_PACKAGES += \
    init.mmi.charge.sh \
    init.mmi.overlay.rc \
    init.oem.fingerprint.sh \
    init.oem.fingerprint2.sh \
    init.qti.chg_policy.sh \
    init.recovery.lkm.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/load_touch.sh:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/bin/load_touch.sh

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light-service.lineage

# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/media_profiles_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml

# NFC
PRODUCT_PACKAGES += \
    android.hardware.nfc-service.nxp

# Power
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/power/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Get non-open-source specific aspects
$(call inherit-product, vendor/motorola/kiev/kiev-vendor.mk)
