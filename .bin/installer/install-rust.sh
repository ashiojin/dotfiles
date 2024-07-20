#!/usr/bin/env bash
set -ue

function install_rustup() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
}

function update_rustup() {
    rustup self update
}

function install_or_update_cargo_make() {
    cargo install cargo-make --locked
}

function is_rustup_installed() {
    if ! [ -x "$(command -v rustup)" ]; then
        return 0
    else
        return 1
    fi
}

if ! is_rustup_installed; then
    install_rustup
else
    update_rustup
fi

install_or_update_cargo_make
