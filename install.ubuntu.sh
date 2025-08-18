#!/bin/bash

# Este script irá instalar o neovim e as dependências
# de build dos plugins. Irá também atualizar a versão
# do git e instalar o Lazygit para facilitar o fluxo
# de trabalho na hora do versionamento.

# Atualiza o repositório e a versão do git
sudo add-apt-repository ppa:git-core/ppa;
sudo apt update;
sudo apt upgrade;

# Instala make e cmake para o build dos plugins
sudo apt install make -y;
sudo apt install cmake -y;

# Instala ripgrep como dependência do live grep
sudo apt install ripgrep -y;

# Instala cURL para download do neovim e lazygit
sudo apt install curl -y;

# Baixa e extrai o neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz; \
rm -rf /opt/nvim; \
tar -C /opt -xzf nvim-linux64.tar.gz; \

# Adiciona o caminho do binário do neovim ao .bashrc
sed -i '$a\export PATH="$PATH:/opt/nvim-linux64/bin"' ~/.bashrc; \

# Instala o lazygit para facilitar o versionamento
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*'); \
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"; \
tar xf lazygit.tar.gz lazygit; \
install lazygit /usr/local/bin;
