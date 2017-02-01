#!/bin/bash
# This script makes Ubuntu 12.04 work

# Run base installer
"$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/setup_ubuntu_base.sh"

rvm system &> /dev/null
cmake_url="https://cmake.org/files/v3.4/cmake-3.4.0.tar.gz"
cmake_vers=$(echo $cmake_url | rev | cut -d '/' -f 1 | rev)
cmake_dir=$(echo $cmake_vers | sed 's/\.tar\.gz//')


setup_vim() {
    # Upgrade vim to 7.4
    # Dependencies
    sudo apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
         libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
         libcairo2-dev libx11-dev libxpm-dev libxt-dev \

    # remove existing vim
    sudo apt-get remove -y vim vim-runtime gvim vim-tiny vim-common vim-gui-common

    # Download and install source
    cd ~ && rm -rf vim
    git clone https://github.com/vim/vim.git
    cd vim
    ./configure --with-features=huge \
                --enable-multibyte \
                --enable-rubyinterp \
                --enable-pythoninterp \
                --with-python-config-dir=/usr/lib/python2.7/config \
                --enable-perlinterp \
                --enable-luainterp \
                --enable-gui=gtk2 --enable-cscope --prefix=/usr
    make VIMRUNTIMEDIR=/usr/share/vim/vim80
    sudo checkinstall  #TODO: automate this


    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
    sudo update-alternatives --set editor /usr/bin/vim
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
    sudo update-alternatives --set vi /usr/bin/vim
}


setup_cmake() {
    # Update cmake for YouCompleteMe
    # no-check-certificate because ubuntu 12.04. TODO: stop using 12.04
    rm -rf "${cmake_dir}"
    cd $HOME && wget $cmake_url --no-check-certificate && \
        tar xvfz $cmake_vers && \
        cd $cmake_dir && \
        rm -rf _build; mkdir _build && cd _build && \
        cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr && \
        make && \
        sudo make install && \
        sudo ldconfig
}

setup_vim
setup_cmake
