FROM rocker/tidyverse:3.5.3
RUN apt-get update \
    && apt-get -y --no-install-recommends install curl
# Installing neovim for rstudio user
USER rstudio
WORKDIR /home/rstudio
RUN wget https://github.com/neovim/neovim/releases/download/v0.3.8/nvim.appimage
RUN chmod u+x nvim.appimage
RUN ./nvim.appimage --appimage-extract
RUN curl -fLo .local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN mkdir -p .config/nvim
# NVim-R configuration for Rstudio
COPY init.vim .config/nvim/init.vim
RUN wget https://github.com/neovim/neovim/releases/download/v0.3.8/nvim.appimage \
  && chmod u+x nvim.appimage \
  && ./nvim.appimage --appimage-extract \
  && curl -fLo .local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
  && mkdir -p .config/nvim \
  && squashfs-root/AppRun +PlugInstall +qall
USER root
RUN ln -s /home/rstudio/squashfs-root/AppRun /usr/local/bin/nvim

#curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#COPY plug.vim /root/.local/share/nvim/site/autoload/plug.vim

