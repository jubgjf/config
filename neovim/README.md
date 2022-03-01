# `neovim` - neovim 键位配置

## 依赖

- packer.nvim
  ```shell
  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  ```
- neovim-symlinks
  用于将 `vi` 、 `vim` 替换为 `nvim`
- stylua
  用于格式化 lua 源文件
- win32yank
  用于在 WSL 中共享 Windows 剪贴板

## 配置

可以将 `CapsLock` 与 `ESC` 交换

```shell
ln -s ~/code/config/neovim ~/.config/nvim
```
