export PATH=$HOME/.local/bin:$PATH

export NVM_DIR="$HOME/.nvm"

#export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

#M2_HOME="$HOME/program/apache-maven-3.8.6"
#PATH="$M2_HOME/bin:$PATH"

#export DENO_INSTALL="$HOME/.deno"
#PATH="$DENO_INSTALL/bin:$PATH"

# PATH: nvim
NVIM_LATEST="$HOME/.local/bin/nvim-0.11/nvim-linux-x86_64"
#  for v0.10 : NVIM_LATEST="$HOME/.local/bin/nvim-linux64"
PATH="${NVIM_LATEST}/bin:$PATH"

# PATH: bats-core
PATH="$HOME/.local/bin/bats/bin:$PATH"

# PATH: tools installed by `yarn global add`
PATH="$HOME/.yarn/bin:$PATH"

# PATH: for binalies from lualocks
PATH="$HOME/.luarocks/bin:$PATH"

export BUN_INSTALL="${HOME}/.local/bun"
PATH="$BUN_INSTALL/bin:$PATH"

export ZIG_INSTALL="${HOME}/.local/zig"
PATH="${ZIG_INSTALL}/using:$PATH"

export PATH

# Cargo
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
