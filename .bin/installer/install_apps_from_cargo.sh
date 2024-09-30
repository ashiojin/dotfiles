#!/usr/bin/env bash
set -ue

function install_apps() {
    # yazi: file manager
    cargo install --locked yazi-fm yazi-cli

    # yazi plugins
    ya pack -a yazi-rs/plugins:git
}

install_apps


