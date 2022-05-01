# `zsh` - zsh 配置

## 安装

```shell
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## 依赖

- zsh 样式
  - zsh-autosuggestions
  - zsh-syntax-highlighting
  - starship
- 字体
  - nerd-fonts-jetbrains-mono
  - nerd-fonts-cascadia-code
- alias 原应用程序
  - bat
  - htop
  - fd
  - fzf
  - ranger
  - unzip
  - rsync
  - ripgrep-all
  - zoxide
  - exa
  - neovim

## 配置

```shell
ln -s ~/code/config/zsh/_zshrc ~/.zshrc
ln -s ~/code/config/zsh/starship.toml ~/.config/starship.toml
```
