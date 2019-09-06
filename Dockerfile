FROM rocker/tidyverse:3.5.3
RUN apt-get update \
    && apt-get -y --no-install-recommends install curl python3-dev python3-pip python3-setuptools
# Install some package dependencies for Vim plugnins
RUN python3 -m pip install wheel \
  && python3 -m pip install pynvim
# Installing neovim for rstudio user
USER rstudio
WORKDIR /home/rstudio
# Copy configuration for Rstudio
COPY init.vim .config/nvim/init.vim
RUN wget https://github.com/neovim/neovim/releases/download/v0.3.8/nvim.appimage
RUN chmod u+x nvim.appimage
RUN ./nvim.appimage --appimage-extract
RUN curl -fLo .local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN mkdir -p .config/nvim
RUN squashfs-root/AppRun +PlugInstall +qall
USER root
RUN ln -s /home/rstudio/squashfs-root/AppRun /usr/local/bin/nvim

#curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#COPY plug.vim /root/.local/share/nvim/site/autoload/plug.vim

