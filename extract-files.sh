#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
        vendor/lib/libmmcamera2_cpp_module.so \
        |vendor/lib/libmmcamera2_dcrf.so \
        |vendor/lib/libmmcamera2_imglib_modules.so \
        |vendor/lib/libmmcamera2_mct.so \
        |vendor/lib/libmmcamera2_pproc_modules.so \
        |vendor/lib/libmmcamera2_q3a_core.so \
        |vendor/lib/libmmcamera2_sensor_modules.so \
        |vendor/lib/libmmcamera2_stats_algorithm.so \
        |vendor/lib/libmmcamera2_stats_modules.so \
        |vendor/lib/libmmcamera_dbg.so \
        |vendor/lib/libmmcamera_imglib.so \
        |vendor/lib/libmmcamera_pdafcamif.so \
        |vendor/lib/libmmcamera_pdaf.so \
        |vendor/lib/libmmcamera_tintless_algo.so \
        |vendor/lib/libmmcamera_tintless_bg_pca_algo.so)
            sed -i 's|data/misc/camera|data/vendor/qcam|g' "${2}"
            ;;
        vendor/lib/libmmcamera2_iface_modules.so)
            sed -i 's|data/misc/camera|data/vendor/qcam|g' "${2}"
            # Always set 0 (Off) as CDS mode in iface_util_set_cds_mode
            sed -i -e 's|\xfd\xb1\x20\x68|\xfd\xb1\x00\x20|g' "${2}"
            PATTERN_FOUND=$(hexdump -ve '1/1 "%.2x"' "${2}" | grep -E -o "fdb10020" | wc -l)
            if [ $PATTERN_FOUND != "1" ]; then
                echo "Critical blob modification weren't applied on ${2}!"
                exit;
            fi
            ;;
        vendor/etc/init/android.hardware.keymaster@3.0-service-qti.rc)
            sed -i 's|4|3|g' "${2}"
            ;;
    esac
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=Tiare
export DEVICE_COMMON=mithorium-common
export VENDOR=xiaomi

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"
