#!/usr/bin/env bash
set -ue

install_0_13() {
    # ZIG_INSTALL should be set
    if [ -z "${ZIG_INSTALL:-}" ]; then
        echo "ERROR: Should set ZIG_INSTALL."
        exit 1
    fi
    mkdir -p "${ZIG_INSTALL}"
    local URL='https://ziglang.org/download/0.13.0/zig-linux-x86_64-0.13.0.tar.xz'
    curl -L "${URL}" | tar -x --xz -C "${ZIG_INSTALL}"
    ln -fs "${ZIG_INSTALL}/zig-linux-x86_64-0.13.0" "${ZIG_INSTALL}/using"
}

install_0_13
