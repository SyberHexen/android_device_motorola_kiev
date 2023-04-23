#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.extract import extract_fns_user_type
from extract_utils.extract_star import extract_star_firmware
from extract_utils.fixups_blob import (
    BlobFixupCtx,
    File,
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)
from extract_utils.tools import (
    llvm_objdump_path,
)
from extract_utils.utils import (
    run_cmd,
)

namespace_imports = [
    'hardware/motorola',
    'vendor/motorola/sm7250-common',
    'vendor/qcom/opensource/display',
]


def blob_fixup_graphic_buffer_size(
    ctx: BlobFixupCtx,
    file: File,
    file_path: str,
    *args,
    **kwargs,
):
    for line in run_cmd(
        [
            llvm_objdump_path,
            '--disassemble-all',
            file_path,
        ]
    ).splitlines():
        line = line.split(maxsplit=5)
        if len(line) != 6:
            continue

        # The size of GraphicBuffer changed from 0x100 to 0xd30
        offset, _, instruction, register, value, _ = line
        if instruction == 'mov' and register[:-1] == 'w0' and value == '#0x100':
            with open(file_path, 'rb+') as f:
                f.seek(int(offset[:-1], 16))
                f.write(b'\x00\xa6\x81\x52')  # AArch64 mov w0, #0xd30


blob_fixups: blob_fixups_user_type = {
    'vendor/lib/hw/audio.primary.lito-moto.so': blob_fixup()
        .replace_needed('android.hardware.power-V1-ndk_platform.so', 'android.hardware.power-V1-ndk.so')
        .replace_needed('libtinyalsa.so', 'libtinyalsa-moto.so'),
    'vendor/lib/hw/sound_trigger.primary.lito.so': blob_fixup()
        .replace_needed('libtinyalsa.so', 'libtinyalsa-moto.so'),
    ('vendor/lib64/com.qti.feature2.gs.so', 'vendor/lib64/com.qti.feature2.gs.bitra.so', 'vendor/lib64/hw/com.qti.chi.override.so', 'vendor/lib64/hw/com.qti.chi.override.bitra.so'): blob_fixup()
        .binary_regex_replace(b'camera.mot.is.coming.cts', b'vendor.camera.coming.cts'),
    'vendor/lib64/camera/components/com.vidhance.node.processing.so': blob_fixup()
        .call(blob_fixup_graphic_buffer_size),
    'vendor/lib64/libvidhance.so': blob_fixup()
        .add_needed('libcomparetf2_shim.so'),
    'vendor/lib64/sensors.moto.so': blob_fixup()
        .add_needed('libbase_shim.so'),
    ('vendor/lib64/vendor.qti.hardware.camera.postproc@1.0-service-impl.so', 'vendor/lib64/vendor.qti.hardware.camera.postproc@1.0-service-impl.bitra.so'): blob_fixup()
        .sig_replace('27 0B 00 94', '1F 20 03 D5'),
}  # fmt: skip

extract_fns: extract_fns_user_type = {
    r'(bootloader|radio)\.img': extract_star_firmware,
}

module = ExtractUtilsModule(
    'kiev',
    'motorola',
    namespace_imports=namespace_imports,
    blob_fixups=blob_fixups,
    extract_fns=extract_fns,
    lib_fixups=lib_fixups,
    add_firmware_proprietary_file=True,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(
        module, 'sm7250-common', module.vendor
    )
    utils.run()
