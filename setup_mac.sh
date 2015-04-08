#!/bin/bash


if ! which brew 2> /dev/null > /dev/null; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    hash -r && brew update
fi

# Generic Ubuntu setup
packages=(
    build-essential
    cmake
    clang
    coreutils
    cpanminus
    curl
    git
    htop
    iftop
    iperf
    netcat
    nmap
    node
    npm
    ntp
    ntp-doc
    python-dev
    python-pip
    python-software-properties
    ruby
    ruby-dev
    rubygems
    software-properties-common
    tree
    wget
    zip
    zsh
)

# base packages
brew update && brew install -y ${packages[@]}
