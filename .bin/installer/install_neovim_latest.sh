#!/usr/bin/env bash
set -ue

function install_neovim_0_10() {
    curl -L https://github.com/neovim/neovim/releases/download/v0.10.3/nvim-linux64.tar.gz | tar zx -C ~/.local/bin/
    ${HOME}/.local/bin/nvim-linux64/bin/nvim --headless "+Lazy! sync" +qa
}

install_neovim_0_10
