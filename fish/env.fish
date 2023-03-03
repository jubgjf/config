# ==========                    ==========
# ========== XDG Base Directory ==========
# ==========                    ==========

# XDG
set XDG_CONFIG_HOME $HOME/.config
set XDG_CACHE_HOME $HOME/.cache
set XDG_DATA_HOME $HOME/.local/share
set XDG_STATE_HOME $HOME/.local/state

# ==========                   ==========
# ========== 一些其他的 export ==========
# ==========                   ==========

# xz 用尽可能多核进行压缩
set XZ_OPT "-T0"

# GPG 签名
set GPG_TTY $(tty)

set VISUAL nvim
set EDITOR nvim

# if [[ "$(uname)" != "Darwin" ]] {
#     # virt-manager 普通用户
#     LIBVIRT_DEFAULT_URI="qemu:///system"

#     # 添加 $HOME/.local/bin 到 PATH
#     PATH=$PATH:$HOME/.local/bin
# }
