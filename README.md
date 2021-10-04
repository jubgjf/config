# config

## `_dwm/` - dwm 自启动脚本

### 依赖

- xinput
- fcitx5
- picom
- feh
  - 背景图片需要存放于 `~/Pictures/wallpapers/`

### 配置

```shell
$ ln -s ~/code/config/_dwm ~/.dwm
```

## `clang/` - clang 格式化风格

### 配置

```shell
$ ln -s ~/code/config/clang/_clang-format ~/.clang-format
```

## `_dmenu/` - dmenu 配置

### `_dmenu/entry/` - dmenu 程序启动脚本

已写入 .zshrc, 此处的命令无需手动配置

```shell
$ export PATH=~/code/config/dmenu/entry/
```

若未生效，可以将 `~/.cache/dmenu_run` 删除，重新在终端运行 `dmenu_run` 即可

## `fcitx5/` - fcitx 输入法配置

### 依赖

```shell
$ yay -S fcitx5-material-color
```

### 配置

```shell
$ ln -s ~/code/config/fcitx5/_pam_environment ~/.pam_environment
```

## `git/` - git 配置

### 配置

```shell
$ ln -s ~/code/config/git/_gitconfig ~/.gitconfig
```

## `haskell/` - haskell 相关配置

### `haskell/_ghci` - ghci 加载项

#### 配置

```shell
$ ln -s ~/code/config/haskell/_ghci ~/.ghci
```

### `haskell/_stylish-haskell.yaml` - stylish-haskell 格式化风格

#### 配置

```shell
$ ln -s ~/code/config/haskell/_stylish-haskell.yaml ~/.stylish-haskell.yaml
```

## `jetbrains/` - ideavim 键位配置

### 配置

```shell
$ ln -s ~/code/config/jetbrains/_ideavim ~/.ideavim
```

## `neovim/` - neovim 键位配置

### 依赖

- vim-plug
  ```shell
  $ sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  ```
- nodejs
- npm

### 配置

```shell
$ ln -s ~/code/config/neovim ~/.config/nvim
```

## `pip/` - pip 配置

### 配置

```shell
$ ln -s ~/code/config/pip ~/.config/pip
```

## `ranger/` - ranger 配置

### 依赖

- ueberzug
- ranger_devicons
  ```shell
  $ git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
  ```

### 配置

```shell
$ ln -s ~/code/config/ranger ~/.config/ranger
```

## `x/` - x 窗口系统配置

### 依赖

```shell
$ yay -S breezex-cursor-theme matcha-gtk-theme
```

### 配置

```shell
$ ln -s ~/code/config/x/_xinitrc ~/.xinitrc
$ ln -s ~/code/config/x/_Xresources ~/.Xresources
```

## `yarn/` - yarn 配置

### 配置

```shell
$ ln -s ~/code/config/yarn/_yarnrc ~/.yarnrc
```

## `zsh/` - zsh 配置

### `zsh/powerlevel10k/` - powerlevel10k 样式配置

#### 安装

```shell
$ git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

#### 依赖

- nerd-fonts-cascadia-code

#### 配置

初次使用时，可用

```shell
$ p10k configure
```

进行配置

生成的配置文件位于 `~/.p10k.zsh`

可用

```shell
$ diff ~/code/config/zsh/powerlevel10k/_p10k.zsh ~/.p10k.zsh
```

进行对比，并手动进行修改

### `zsh/_zshrc` - zsh 配置

#### 安装

```shell
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### 依赖

- zsh-autosuggestions
  ```shell
  $ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  ```
- zsh-syntax-highlighting
  ```shell
  $ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  ```

#### 配置

```shell
$ ln -s ~/code/config/zsh/_zshrc ~/.zshrc
$ source ~/.zshrc
```

### `zsh/_zprofile` - zsh 启动脚本

#### 配置

```shell
$ ln -s ~/code/config/zsh/_zprofile ~/.zprofile
```
