# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Use git_ps1
# Supress some git_ps1 features which slows down the console.
export GIT_PS1_SHOWDIRTYSTATE=
export GIT_PS1_SHOWUNTRACKEDFILES=
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]$(__git_ps1 "%s@")\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:$(__git_ps1 "%s@")\W\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# # Color Definitions 
# e.g. `echo -e "${ClRed}Here is red${ClReset}Here is normal color"`
#  shellcheck disable=SC2034
ClReset='\033[0m'
#  shellcheck disable=SC2034
ClRed='\033[0;31m'
#  shellcheck disable=SC2034
ClRedRev='\033[7;31m'
#  shellcheck disable=SC2034
ClYellow='\033[0;33m'
#  shellcheck disable=SC2034
ClYellowItalic='\033[3;33m'
#  shellcheck disable=SC2034
ClYellowUnderline='\033[4;33m'
#  shellcheck disable=SC2034
ClYellowCrossout='\033[9;33m'
#  shellcheck disable=SC2034
ClBgYellow='\033[0;30;43m'

#
set -o vi
export EDITOR=nvim

alias gl='git log --oneline --graph'
alias gs='git status'
alias _dropcaches='sudo sh -c "echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a"'



export PATH=$HOME/.local/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"

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

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Cargo
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"

# TODO: Only for WSL2
# Aliases for Windows Applications
alias foxitrd='/mnt/c/Program\ Files\ \(x86\)/Foxit\ Software/Foxit\ PDF\ Reader/FoxitPDFReader.exe'


sl() {
    echo "____🚂____"
}

# Per machine environments
if [ -f ~/.bashrc.local.bash ]; then
    # shellcheck disable=SC1090
  . ~/.bashrc.local.bash
fi

# Health check
function warn_if_env_isnt_set() {
    local -n envname=${1}
    [[ -z "${envname}" ]] && echo -e "${ClBgYellow}[Warn]${ClReset} ${!envname} isn't set. Check ~/.bashrc.local.bash"
}
function health_check() {
    # For avante.nvim
    warn_if_env_isnt_set ANTHROPIC_API_KEY
}

health_check

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
