#!/usr/bin/env bash
set -ue

function install() {
    sudo apt install -y curl wget gawk python3-pip unzip
    sudo apt install -y fd-find ripgrep
    sudo apt install -y pkgconf libasound2-dev libudev-dev # required by rust-analyzer(to analyze bevy?)

    sudo apt install -y clang lld
    sudo apt install -y shellcheck
    # Ubuntu's fd package uses `fdfind` as the binary, not the expected `fd`.
    ln -snf $(which fdfind) ~/.local/bin/fd
}

install
