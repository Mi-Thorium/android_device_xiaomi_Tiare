/*
 * Copyright (C) 2021 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <libinit_utils.h>

#include "vendor_init.h"

void vendor_load_properties() {
    set_ro_build_prop("device", "tiare", true);
}
