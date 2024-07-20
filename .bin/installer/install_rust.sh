#!/usr/bin/env bash
set -ue

function install_rustup() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    . "$HOME/.cargo/env"
}

function update_rustup() {
    rustup self update
}

function install_or_update_cargo_make() {
    cargo install cargo-make --locked
}

if ! [ -x "$(command -v rustup)" ]; then
    install_rustup
else
    update_rustup
fi

install_or_update_cargo_make
