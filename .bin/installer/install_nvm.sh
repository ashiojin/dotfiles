#!/usr/bin/env bash
set -ue

function install_nvm() {
  if ! command -v nvm 2>&1 >/dev/null
  then
    PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash'
  fi

  echo " - install latest npm"
  source "$NVM_DIR/nvm.sh" --no-use
  echo "  - install latest"
  nvm install --lts --latest-npm
  echo "  - use latest"
  nvm alias default node
}

install_nvm

