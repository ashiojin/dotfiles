#!/usr/bin/env bash
set -ue

function apply-patch-to-which-key() {
    PATCH="${HOME}/.bin/installer/patch/which-key_v3.13.2.patch"
    SRC="${HOME}/.config/nvim/src"
    WHICHKEY="${SRC}/which-key.nvim"

    cd "${WHICHKEY}"
    patch -p1 < "${PATCH}"
}

apply-patch-to-which-key
