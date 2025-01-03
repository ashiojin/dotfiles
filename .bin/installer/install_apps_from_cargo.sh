#!/usr/bin/env bash
set -ue

function install_apps() {
    # yazi: file manager
    cargo install --locked yazi-fm yazi-cli

    # yazi plugins
    local t=$(ya pack --list | grep 'yazi-rs/plugins:git')
    if [[ -n "$t" ]]; then
        command echo "yazi-rs/plusins:git already installed"
    else
        ya pack -a yazi-rs/plugins:git
    fi
}

install_apps


