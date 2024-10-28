# ========== XDG 规范 ==========

set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state

# ========== 其他 ==========

# xz 用尽可能多核进行压缩
set -x XZ_OPT "-T0"

# GPG 签名
set -x GPG_TTY (tty)

# 默认编辑器
set -x VISUAL nvim
set -x EDITOR nvim

# 环境路径
set -x PATH $HOME/.cargo/bin $PATH  # cargo
set -x PATH $HOME/.local/bin $PATH  # 一些手动设置的 bin

# rbenv
if test -f $HOME/.rbenv/bin/rbenv
    $HOME/.rbenv/bin/rbenv init - --no-rehash fish | source
end

# Homebrew
if test (uname) = "Darwin"
    eval "(/opt/homebrew/bin/brew shellenv)"
end

# zoxide
zoxide init --cmd cd fish | source

# slurm
if string match -qr "^dmx|g400|g00" (uname -n)
  set -x PATH $PATH /opt/slurm/bin/
end
