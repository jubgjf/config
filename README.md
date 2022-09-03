# config

各种配置文件

## Homebrew 安装

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## zsh 配置

```shell
# oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# oh my zsh 插件
brew install starship zsh-autosuggestions zsh-syntax-highlighting

# 字体
brew install homebrew/cask-fonts/font-jetbrains-mono-nerd-font

# alias 中的程序
brew install exa bat fd fzf ranger unzip rsync ripgrep-all zoxide

# 其他程序
brew install gpg pinentry-mac
brew install --cask anaconda
```

```shell
ln -s ~/code/config/zsh/zsh/_zshrc ~/.zshrc
source ~/.zshrc
zsh $CONFIG_HOME/install.zsh
```
