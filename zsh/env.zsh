# ==========                    ==========
# ========== XDG Base Directory ==========
# ==========                    ==========

# XDG
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share
XDG_STATE_HOME=$HOME/.local/state

# ==========                   ==========
# ========== other export ==========
# ==========                   ==========

# xz 用尽可能多核进行压缩
XZ_OPT="-T0"

# GPG 签名
GPG_TTY=$(tty)

# 默认编辑器
VISUAL=nvim
EDITOR=nvim

# 一些 bin 文件路径
PATH=$PATH:$HOME/.local/bin

# virt-manager 普通用户
# LIBVIRT_DEFAULT_URI="qemu:///system"
