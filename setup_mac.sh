#!/bin/bash # Generic MacOS setup!
set -e

homebrew_url=https://raw.githubusercontent.com/Homebrew/install/master/install

packages=(
    ag
    awk
    awscli
    bash
    binutils
    cmake
    coreutils
    diffutils
    findutils
    fzf
    gdb
    git
    gnu-sed
    grep
    htop
    iftop
    iperf
    iproute2mac
    jq
    less
    lsof
    make
    moreutils
    nano
    netcat
    node
    nvim
    openssl         # For pyenv builds
    pipenv
    pyenv
    python
    readline        # For pyenv builds
    shfmt
    stack
    tcl-tk          # For pyenv builds
    tmux
    tmuxinator
    tree
    vim
    watch
    wget
    yq
    zip
    zsh
)

cask_packages=(
    charles
    docker
    google-cloud-sdk
    google-chrome
    google-earth-pro
    iterm2
    mactex
    spotify
    vagrant
    vagrant-manager
    virtualbox
    virtualbox-extension-pack
    wireshark
)

gcloud_components=(
    alpha
    beta
    gsutil
    kubectl
    minikube
)

# Run it!
if ! which brew 2> /dev/null > /dev/null; then
    ruby -e "$(curl -fsSL "$homebrew_url")"
    hash -r
fi

brew update
brew upgrade
brew cask upgrade
brew install "${packages[@]}"
brew cask install "${cask_packages[@]}"

gcloud components install --quiet "${gcloud_components[@]}"
