# This repo is supposed to be used as config by NvChad v2 users!

- require neovim version 0.11.4+
- The main nvchad repo (NvChad/NvChad) is used as a plugin by this repo.
- So you just import its modules , like `require "nvchad.options" , require "nvchad.mappings"`
- So you can delete the .git from this repo ( when you clone it locally ) or fork it :)

## Install Neovim and NvChad

https://neovim.io/doc2/install/

https://nvchad.com/docs/quickstart/install

install neovim on debian
```shell
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
```

## Features

[x] lsp for lua/c/cpp/go
[x] formatter for lua/c/cpp/go
[x] debugger for c/cpp/go
[] support for cmake/makefile


## Credits

1) Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!
