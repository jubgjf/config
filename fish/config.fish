if status is-interactive
    # Commands to run in interactive sessions can go here
end

set uname (uname -n)
if string match -qr "^hpc-login|gpu|dmx|g400|ln01|g00" $uname
  # JuNest 初始化
  set -x PATH $PATH $HOME/.junest/usr/bin_wrappers $HOME/.local/share/junest/bin
end

# config 总目录
if string match -qr "^ln01|gpu" $uname; and string match -r "Rocky" (head -n 1 /etc/os-release)
  set -x CONFIG_HOME $HOME/jnguan/code/config
else
  set -x CONFIG_HOME $HOME/code/config
end

# 一些环境变量
source $HOME/.config/fish/env.fish

# source 一下其他的配置
source $XDG_CONFIG_HOME/fish/alias.fish
source $XDG_CONFIG_HOME/fish/conda.fish
