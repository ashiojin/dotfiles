#!/usr/bin/env bash
set -ue

install_() {
    # BUN_INSTALL should be set in .bashrc
    curl -fsSL https://bun.sh/install | bash
}

install_
