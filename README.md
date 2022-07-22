# config

各种配置文件

## zsh 配置

```shell
# oh my zsh 及其插件
sudo pacman -S oh-my-zsh-git starship zsh-autosuggestions zsh-syntax-highlighting

# 字体
sudo pacman -S nerd-fonts-jetbrains-mono

# alias 中的程序
sudo pacman -S bat fd fzf ranger unzip rsync ripgrep-all zoxide

# neovim
sudo pacman -S neovim neovim-symlinks

# 其他程序
sudo pacman -S htop anaconda ueberzug ffmpeg ffmpegthumbnailer
```

```shell
ln -s ~/code/config/zsh/zsh/_zshrc ~/.zshrc
source ~/.zshrc
zsh $CONFIG_HOME/install.zsh
```
