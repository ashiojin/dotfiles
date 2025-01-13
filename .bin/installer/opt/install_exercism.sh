#!/usr/bin/env bash
set -ue

install_exercism() {
    local tmpdir="$(mktemp -d)"
    echo "Install exercism (tmpdir: $tmpdir)"
    if [[ -n "$tmpdir" ]]; then
        # trap 'rm -rf "${tmpdir}"' 1 2 3 15

        curl -L https://github.com/exercism/cli/releases/download/v3.5.4/exercism-3.5.4-linux-$(uname -m).tar.gz > exercism.tar.gz
        tar -xf exercism.tar.gz -C "${tmpdir}"

        mv "${tmpdir}/exercism" ~/.local/bin/

        rm -rf "${tmpdir}"

        echo -e "\e[33m[INFO]\e[m You will need to configure Exercism CLI before using it"
        echo " See: https://exercism.org/cli-walkthrough"
    fi
}

install_exercism
