#!/bin/bash
# brew cask installs GUI based applications

script_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$script_home/lib_sh/echos.sh"
source "$script_home/lib_sh/requirers.sh"

echo "==> Installing desktop apps via Homebrew Cask..."

for i in \
  caffeine \
  firefox \
  ghostty \
  klayout \
  notion \
  vscodium \
  zen
do
  require_cask $i
done

# Add link to klayout binary to shell
ln -s /Applications/KLayout/klayout.app/Contents/MacOS/klayout $HOME/.local/bin/klayout

echo "==> Done! Desktop apps installed."
