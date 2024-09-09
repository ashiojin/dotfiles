#!/usr/bin/env bash
set -ue

function install_bats_core() {
    workdir=$(mktemp -d "intall_bats_core.XXXXXXXX")
    gitdir="${workdir}/bats-core"
    git clone https://github.com/bats-core/bats-core "${gitdir}"

    "${gitdir}/install.sh" ~/.local/bin/bats

    rm -rf "${workdir}"
}

install_bats_core
