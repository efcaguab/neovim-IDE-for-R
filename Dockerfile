FROM rocker/tidyverse:3.5.3

## THE FOLLOWING BLOCK INSTALLS NEOVIM
RUN apt-get update \
    && apt-get -y --no-install-recommends install curl python3-dev python3-pip python3-setuptools
# Install some python pre-requisites for neovim plugnins
COPY init.vim /root/.config/nvim/init.vim
# Pyton requirements for autocompletion
RUN python3 -m pip install wheel \
  && python3 -m pip install pynvim \
# Install neovim software
  && wget https://github.com/neovim/neovim/releases/download/v0.3.8/nvim.appimage \
  && chmod u+x nvim.appimage \
  && ./nvim.appimage --appimage-extract \
  && ln -s /squashfs-root/AppRun /usr/local/bin/nvim \
# Install plugins
  && curl -fLo /root/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
  && squashfs-root/AppRun +PlugInstall +qall 

