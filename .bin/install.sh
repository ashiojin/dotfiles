#!/usr/bin/env bash
set -ue

helpmsg() {
  command echo "Usage: $0 [--help | -h]" 0>&2
  command echo ""
}

link_to_homedir() {
  command echo "# backup old dotfiles..."
  if [ ! -d "$HOME/.dotbackup" ];then
    command echo "$HOME/.dotbackup not found. Auto Make it"
    command mkdir "$HOME/.dotbackup"
  fi

  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  local dotdir=$(dirname ${script_dir})
  if [[ "$HOME" != "$dotdir" ]];then
    for f in $dotdir/.??*; do
      [[ `basename $f` == ".git" ]] && continue
      command echo "Make link to $f"
      if [[ -L "$HOME/`basename $f`" ]];then
        command echo " $HOME/`basename $f` is a symbolic link. Remove it."
        command rm -f "$HOME/`basename $f`"
      fi
      if [[ -e "$HOME/`basename $f`" ]];then
        command echo " backup $HOME/`basename $f`"
        command mv "$HOME/`basename $f`" "$HOME/.dotbackup"
      fi
      command ln -snf $f $HOME
    done
  else
    command echo "same install src dest"
  fi
}

call_installers() {
  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

  command echo "# Call installers:"
  command echo "## required_packages.sh:"
  source "${script_dir}"/installer/install_required_packages.sh

  command echo "## nvm:"
  source "${script_dir}"/installer/install_nvm.sh

  command echo "## neovim:"
  source "${script_dir}"/installer/install_neovim_latest.sh
  command echo "## rust:"
  source "${script_dir}"/installer/install_rust.sh

  command echo "## bats-core:"
  source "${script_dir}"/installer/install_bats-core.sh

  command echo "## apps_from_cargo:"
  source "${script_dir}"/installer/install_apps_from_cargo.sh

  command echo "## patch which-key.nvim:"
  source "${script_dir}"/installer/patch-which-key-nvim.sh
}

while [ $# -gt 0 ];do
  case ${1} in
    --debug|-d)
      set -uex
      ;;
    --help|-h)
      helpmsg
      exit 1
      ;;
    *)
      ;;
  esac
  shift
done

link_to_homedir
source "$HOME/.bashrc"
call_installers

git config --global include.path "$HOME/.gitconfig_shared"
source "$HOME/.bashrc"
command echo -e "\e[1;36m Install completed!!!! \e[m"
