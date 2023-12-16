#!/bin/zsh
# shellcheck disable=SC2086,SC2016
set -eu

TMP_DIRECTORY=$(mktemp -d)
BIN_DIRECTORY="$HOME/bin"
INCLUDE_DIRECTORY="$HOME/include"

function brew_install_or_upgrade {
  if [[ "$1" == *"--cask"* ]]; then
    CASK_NAME=$(echo $1 | cut -c'8-')
    if brew list --versions --cask $CASK_NAME >/dev/null; then
      HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade --force --cask $CASK_NAME
    else
      HOMEBREW_NO_AUTO_UPDATE=1 brew install --cask $CASK_NAME
    fi
  else
    if brew list --versions $1 >/dev/null; then
      HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade --force $1
    else
      HOMEBREW_NO_AUTO_UPDATE=1 brew install --overwrite $1
    fi
  fi
}

##### Install tools #####

cd "$TMP_DIRECTORY"
mkdir -p "$BIN_DIRECTORY"
mkdir -p "$INCLUDE_DIRECTORY"

# #infra
brew_install_or_upgrade direnv
brew_install_or_upgrade xz
brew_install_or_upgrade detect-secrets
brew_install_or_upgrade awscli
brew_install_or_upgrade aws-iam-authenticator
brew_install_or_upgrade hadolint
brew_install_or_upgrade tflint
brew_install_or_upgrade kubectl
brew_install_or_upgrade shellcheck
brew_install_or_upgrade tfenv
brew_install_or_upgrade kubectx
brew_install_or_upgrade eksctl
brew_install_or_upgrade helm
brew_install_or_upgrade pinentry-mac
brew_install_or_upgrade gpg2
brew_install_or_upgrade gh
brew_install_or_upgrade telnet
brew_install_or_upgrade argo
brew_install_or_upgrade argocd
brew_install_or_upgrade tctl
brew_install_or_upgrade "--cask docker"

#productivity
brew_install_or_upgrade "--cask rectangle"
brew_install_or_upgrade "--cask iterm2"
brew_install_or_upgrade "--cask slack"
brew_install_or_upgrade "--cask visual-studio-code"
brew_install_or_upgrade "--cask lens"
brew_install_or_upgrade "--cask monitorcontrol"
brew_install_or_upgrade "--cask postman"
brew_install_or_upgrade "--cask google-chrome"
brew_install_or_upgrade "--cask whatsapp"
brew_install_or_upgrade "--cask figma"
brew_install_or_upgrade "--cask google-drive"
brew_install_or_upgrade "--cask cyberduck"
brew_install_or_upgrade "--cask logi-options-plus"
brew_install_or_upgrade "--cask wireshark"
brew_install_or_upgrade "--cask discord"
brew_install_or_upgrade "--cask notion"
brew_install_or_upgrade redpanda-data/tap/redpanda
brew_install_or_upgrade "--cask mongodb-compass"
brew_install_or_upgrade "--cask arctype"
brew_install_or_upgrade "--cask redisinsight"


if [ ! -d $HOME/.config/direnv ]; then

  if [ $SHELL == "/bin/bash" ]; then
    echo >>~/.bashrc
    echo '# Wire up `direnv` to the `cd` command of the shell' >>~/.bashrc
    echo 'eval "$(direnv hook bash)"' >>~/.bashrc
    echo >>~/.bashrc
    echo '# Increase the timeout for triggering the warning message' >>~/.bashrc
    echo '# on long running commands invoked by `direnv`' >>~/.bashrc
    echo 'export DIRENV_WARN_TIMEOUT=30s' >>~/.bashrc
  fi

  if [ $SHELL == "/bin/zsh" ]; then
    echo >>~/.zshrc
    echo '# Wire up `direnv` to the `cd` command of the shell' >>~/.zshrc
    echo 'eval "$(direnv hook zsh)"' >>~/.zshrc
    echo >>~/.zshrc
    echo '# Increase the timeout for triggering the warning message' >>~/.zshrc
    echo '# on long running commands invoked by `direnv`' >>~/.zshrc
    echo 'export DIRENV_WARN_TIMEOUT=30s' >>~/.zshrc
  fi
fi

# Install ClangFormat
brew_install_or_upgrade clang-format

echo ""
echo "Development environment was successfully installed!"
echo ""

if [ $SHELL == "/bin/bash" ]; then
  echo ''
  echo 'IMPORTANT: Run "source ~/.bashrc" or start a new shell to finish setting up `direnv`.'
  echo ''
fi

if [ $SHELL == "/bin/zsh" ]; then
  echo ''
  echo 'IMPORTANT: Run "source ~/.zshrc" or start a new shell to finish setting up `direnv`.'
  echo ''
fi

bin/zsh
