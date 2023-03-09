#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Kernel
TARGET_USES_MITHORIUM_KERNEL := true

# Partitions
BOARD_VENDORIMAGE_EXTFS_INODE_COUNT := 4096
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_RESERVED_SIZE := 41943040

# Inherit from common mithorium-common
include device/xiaomi/mithorium-common/BoardConfigCommon.mk

DEVICE_PATH := device/xiaomi/Tiare
USES_DEVICE_XIAOMI_TIARE := true

# Asserts
TARGET_OTA_ASSERT_DEVICE := tiare,Tiare,Tiare_4_19

# Boot animation
TARGET_BOOTANIMATION := $(DEVICE_PATH)/prebuilt/bootanimation.zip

# Camera
#MI8937_CAM_USE_LATEST_CAMERA_STACK := true
ifeq ($(TARGET_KERNEL_VERSION),4.19)
TARGET_SUPPORT_HAL1 := false
endif

# Display
TARGET_SCREEN_DENSITY := 280

# Filesystem
BOARD_EROFS_USE_LEGACY_COMPRESSION := true

# HIDL
DEVICE_MANIFEST_FILE += $(COMMON_PATH)/configs/manifest/gatekeeper.xml
DEVICE_MANIFEST_FILE += $(COMMON_PATH)/configs/manifest/keymaster.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):init_xiaomi_tiare
TARGET_RECOVERY_DEVICE_MODULES := init_xiaomi_tiare

# Kernel
BOARD_KERNEL_CMDLINE += androidboot.android_dt_dir=/non-existent androidboot.boot_devices=soc/7824900.sdhci
BOARD_KERNEL_CMDLINE += earlycon=msm_serial_dm,0x78af000
BOARD_KERNEL_CMDLINE += cgroup.memory=nokmem,nosocket
BOARD_RAMDISK_USE_XZ := true

ifeq ($(TARGET_KERNEL_VERSION),4.19)
TARGET_KERNEL_CONFIG += \
    vendor/msm8937-legacy.config
endif
TARGET_KERNEL_CONFIG += \
    vendor/feature/erofs.config \
    vendor/xiaomi/msm8937/common.config \
    vendor/xiaomi/msm8937/tiare.config

ifeq ($(MI8937_CAM_USE_LATEST_CAMERA_STACK),true)
TARGET_KERNEL_CONFIG += vendor/xiaomi/msm8937/optional/latest-camera-stack.config
endif

ifeq ($(TARGET_KERNEL_VERSION),4.19)
TARGET_KERNEL_RECOVERY_CONFIG += \
    vendor/msm8937-legacy.config
endif
TARGET_KERNEL_RECOVERY_CONFIG += \
    vendor/feature/no-audio-stack.config \
    vendor/xiaomi/msm8937/common.config \
    vendor/xiaomi/msm8937/tiare.config

# Malloc
MALLOC_SVELTE := true

# Partitions
TARGET_COPY_OUT_VENDOR := vendor
BOARD_BOOTIMAGE_PARTITION_SIZE := 50331648
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 25165824
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1971322880

BOARD_SUPER_PARTITION_BLOCK_DEVICES := system vendor
BOARD_SUPER_PARTITION_METADATA_DEVICE := system
BOARD_SUPER_PARTITION_CACHE_DEVICE_SIZE := 157286400
BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE := 1390411776
BOARD_SUPER_PARTITION_VENDOR_DEVICE_SIZE := 333447168
BOARD_SUPER_PARTITION_SIZE := $(shell expr $(BOARD_SUPER_PARTITION_CACHE_DEVICE_SIZE) + $(BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE) + $(BOARD_SUPER_PARTITION_VENDOR_DEVICE_SIZE) )

BOARD_SUPER_PARTITION_GROUPS := tiare_dynpart
BOARD_TIARE_DYNPART_SIZE := $(shell expr $(BOARD_SUPER_PARTITION_SIZE) - 4194304 )
BOARD_TIARE_DYNPART_PARTITION_LIST := system vendor

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Power
TARGET_TAP_TO_WAKE_NODE := "/proc/sys/dev/xiaomi_msm8937_touchscreen/enable_dt2w"

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom

# Security patch level
VENDOR_SECURITY_PATCH := 2021-01-05

# Sepolicy
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# Inherit from the proprietary version
include vendor/xiaomi/Tiare/BoardConfigVendor.mk
