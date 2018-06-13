# vim_setup

This repo contains scripts to setup vim for development

## Getting started

### Pre-requirements
    This outlines the setup process for vim in an ubuntu machine
    You can replicate similar steps for mac or other linux flavours
    Please feel free to contribute with PRs

1. Remove existing vim installation
    ```shell
    # Remove existing vim installation
    sudo apt-get ourge vim vim-runtime gvim vim-tiny vim-common vim-gui-common
    ```
    # Install terraform (Optional)
    ```
    wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
    unzip terraform_0.11.7_linux_amd64.zip
    mv terraform $HOME/bin
    ```

2. Setup the vim dependencies
    ```shell
    # Get the build dependencies for vim
    sudo apt-get build-dep vim-gnome
    sudo apt-get install --no-recommends \
      liblua5.1-dev \
      libluajit-5.1-dev \
      python-dev \
      ruby-dev \
      libperl-dev \
      libncurses5-dev \
      libgnome2-dev \
      libgnomeui-dev \
      libgtk2.0-dev \
      libatk1.0-dev \
      libbonoboui2-dev \
      libcairo2-dev \
      libx11-dev \
      libxpm-dev \
      libxt-dev
    ```

3. Setup the lua headers for vim installation with lua
    ```shell
    # Prep lua headers for vim
    sudo mkdir -p /usr/include/lua5.1/include &&
    sudo mv /usr/include/lua5.1/*.h /usr/include/lua5.1/include >/dev/null 2>&1
    ```

4. Get vim source
    ```shell
    # Get vim source
    sudo mkdir -p ~/lib
    sudo cd ~/lib
    sudo rm -rf vim >/dev/null 2>&1 && git clone https://github.com/vim/vim
    ```

5. Install vim
    ```shell
    # Configure vim
    sudo cd ~/lib/vim
    sudo make distclean
    sudo ./configure --with-features=huge \
      --enable-multibyte \
      --enable-rubyinterp \
      --enable-largefile \
      --disable-netbeans \
      --enable-pythoninterp \
      --with-python-config-dir=$(find /usr/lib/ -maxdepth 1 -name "python2.*" -type d | sort -V | tail -n 1) \
      --enable-perlinterp \
      --enable-luainterp \
      --with-luajit \
      --enable-gui=auto \
      --enable-fail-if-missing \
      --with-lua-prefix=/usr/include/lua5.1 \
      --prefix=/usr \
      --enable-clipboard \
      --enable-cscope
    sudo make
    sudo cd ~/lib/vim && make install
    ```

### Setting up vim config using this repo

1. Setup the vim config using this repo

    Make sure you have compiled vim as stated in the pre requisites
    Some plugins will not work if vim hasn't been compiled properly

    ```shell
    curl -s -S -L https://raw.githubusercontent.com/sumanmukherjee03/vim_setup/master/bootstrap.sh | bash
    cd ~/.vim
    make
    ```

### Post install notes

1. For vim-go to work properly

    Make sure you have installed the go tooling with :GoInstallBinaries
