#!/usr/bin/env bash
set -ue

function install_neovim_0_1x() {
    # nvim 0.10
    curl -L https://github.com/neovim/neovim/releases/download/v0.10.3/nvim-linux64.tar.gz | tar zx -C ~/.local/bin/
    "${HOME}/.local/bin/nvim-linux64/bin/nvim" --headless "+Lazy! sync" +qa

    # nvim 0.11
    mkdir -p ~/.local/bin/nvim-0.11/
    curl -L https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-linux-x86_64.tar.gz | tar zx -C ~/.local/bin/nvim-0.11/
    "${HOME}/.local/bin/nvim-0.11/nvim-linux-x86_64/bin/nvim" --headless "+Lazy! sync" +qa
}

install_neovim_0_1x
