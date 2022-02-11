# `zsh` - zsh 配置

## 安装

```shell
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## 依赖

- zsh-autosuggestions
  ```shell
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  ```
- zsh-syntax-highlighting
  ```shell
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  ```
- powerlevel10k
  ```shell
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  ln -s ~/code/config/zsh/powerlevel10k/_p10k.zsh ~/.p10k.zsh
  ```
- nerd-fonts-cascadia-code

## 配置

```shell
ln -s ~/code/config/zsh/_zshrc ~/.zshrc
```
