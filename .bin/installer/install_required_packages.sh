#!/usr/bin/env bash
set -ue

function install() {
    sudo apt install -y curl wget gawk python3-pip
    sudo apt install -y fd-find ripgrep

    # Ubuntu's fd package uses `fdfind` as the binary, not the expected `fd`.
    ln -snf $(which fdfind) ~/.local/bin/fd
}

install
