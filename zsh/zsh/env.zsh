# ==========                    ==========
# ========== XDG Base Directory ==========
# ==========                    ==========

# XDG
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share
XDG_STATE_HOME=$HOME/.local/state

# 需要手动指定 XDG 优先级的应用
NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
WGETRC=$XDG_CONFIG_HOME/wgetrc
ZSH_CACHE_DIR=$XDG_CACHE_HOME/oh-my-zsh

# ==========                   ==========
# ========== 一些其他的 export ==========
# ==========                   ==========

# virt-manager 普通用户
LIBVIRT_DEFAULT_URI="qemu:///system"

# 添加 $HOME/.local/bin 到 PATH
PATH=$PATH:$HOME/.local/bin

# xz 用尽可能多核进行压缩
XZ_OPT="-T0"

# GPG 签名
GPG_TTY=$(tty)
