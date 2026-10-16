#!/usr/bin/env bash
set -ue

function install_apps() {
    # yazi: file manager
    cargo install --force yazi-build
    # OLD: cargo install --locked yazi-fm yazi-cli
    # * see: https://yazi-rs.github.io/docs/installation/#crates

    # yazi plugins
    local t=$(ya pkg list | grep 'yazi-rs/plugins:git')
    if [[ -n "$t" ]]; then
        command echo "yazi-rs/plusins:git already installed"
        ya pkg upgrade # it can be failed.
    else
        ya pkg add yazi-rs/plugins:git
    fi

    # tree-sitter-cli
    cargo install --locked tree-sitter-cli
}

install_apps


