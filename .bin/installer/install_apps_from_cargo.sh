#!/usr/bin/env bash
set -ue

function install_apps() {
    # yazi: file manager
    cargo install --locked yazi-fm yazi-cli
}

install_apps


