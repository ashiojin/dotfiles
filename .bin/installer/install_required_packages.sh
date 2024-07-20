#!/usr/bin/env bash
set -ue

function install() {
    sudo apt install -y curl wget gawk python3-pip
}

install
