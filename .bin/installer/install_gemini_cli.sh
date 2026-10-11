#!/usr/bin/env bash
set -ue

function install_gemini_cli() {
    # pre-requisite: npm
    if ! command -v npm &> /dev/null; then
        echo "npm is not installed. Please install Node.js and npm first."
        exit 1
    fi

    npm install -g @google/gemini-cli@latest
}

install_gemini_cli

