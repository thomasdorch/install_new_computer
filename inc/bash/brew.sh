#!/bin/bash

script_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$script_home/lib_sh/echos.sh"
source "$script_home/lib_sh/requirers.sh"

echo "==> Installing Homebrew and core packages..."

################################
# install brew
################################
running "checking homebrew install"
brew_bin=$(which brew) 2>&1 > /dev/null
if [[ $? != 0 ]]; then
  # Homebrew installer requires admin privileges
  if ! dseditgroup -o checkmember -m "$(whoami)" admin &>/dev/null; then
    error "Homebrew installation requires an administrator account."
    error "Your user ‘$(whoami)’ is not in the admin group."
    error "Either run this from an admin account, or add your user to the admin group:"
    error "  sudo dseditgroup -o edit -a $(whoami) -t user admin"
    exit 2
  fi
  action "installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ $? != 0 ]]; then
      error "unable to install homebrew, script $0 abort!"
      exit 2
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
  ok
  # Make sure we’re using the latest Homebrew
  # running "updating homebrew"
  # brew update
  # ok
fi

################################
# Basic software
################################

for i in \
  atuin \
  autojump \
  automake \
  awk \
  bash \
  bat \
  bottom \
  dust \
  ez \
  fastmod \
  fd \
  fzf \
  git-delta \
  git-lfs \
  go \
  hyperfine \
  lazygit \
  lf \
  lsd \
  just \
  m-cli \
  mcfly \
  mpv \
  neovim \
  node \
  postgres \
  ripgrep \
  s-search \
  s3fs \
  sd \
  shellcheck \
  skim \
  starship \
  tmux \
  tokei \
  tree \
  vim \
  wget \
  yarn \
  zoxide \
  font-liberation-nerd-font \
  ;
do
  require_brew $i
done

echo "==> Done! Homebrew packages installed."
