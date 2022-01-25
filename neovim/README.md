# `neovim` - neovim 键位配置

## 依赖

- vim-plug
  ```shell
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  ```
- neovim-symlinks
  可选，用于将 `vi` 、 `vim` 替换为 `nvim`
- nodejs
- npm

## 配置

```shell
ln -s ~/code/config/neovim/nvim ~/.config/nvim
ln -s ~/code/config/neovim/ultisnips ~/.config/coc/ultisnips
```
