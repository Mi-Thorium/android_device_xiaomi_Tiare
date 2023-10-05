#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Kernel
TARGET_KERNEL_VERSION := 4.9

# Inherit from Tiare device
$(call inherit-product, device/xiaomi/Tiare/device.mk)

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_o_mr1.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := Tiare
PRODUCT_NAME := aosp_Tiare
BOARD_VENDOR := Xiaomi
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Redmi Go
PRODUCT_MANUFACTURER := Xiaomi
TARGET_VENDOR := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="tiare-user 8.1.0 OPM1.171019.026 V10.2.25.0.OCLMIXM release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := "Xiaomi/tiare/tiare:8.1.0/OPM1.171019.026/V10.2.25.0.OCLMIXM:user/release-keys"

# Extra
EXTRA_LITE := true
