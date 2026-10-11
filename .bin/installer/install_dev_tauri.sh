#!/usr/bin/env bash
set -ue

install_() {
    sudo apt install -y libwebkit2gtk-4.1-dev \
        librsvg2-dev

    cargo install create-tauri-app --locked
    cargo create-tauri-app
}

install_
