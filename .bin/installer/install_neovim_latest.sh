#!/usr/bin/env bash
set -ue

function install_neovim_latest() {
    curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz | tar zx --strip-components 1 -C ~/.bin/bin/
}

install_neovim_latest
