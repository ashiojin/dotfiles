#!/usr/bin/env bash
set -ue

function install_neovim_0_10() {
    curl -L https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz | tar zx -C ~/.local.bin/
}

install_neovim_0_10
