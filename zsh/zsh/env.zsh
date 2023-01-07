# ==========                    ==========
# ========== XDG Base Directory ==========
# ==========                    ==========

# XDG
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share
XDG_STATE_HOME=$HOME/.local/state

# ==========                   ==========
# ========== 一些其他的 export ==========
# ==========                   ==========

# Starship 配置路径
STARSHIP_CONFIG=$CONFIG_HOME/zsh/starship/starship.toml

# xz 用尽可能多核进行压缩
XZ_OPT="-T0"

# GPG 签名
GPG_TTY=$(tty)

if [[ "$(uname)" != "Darwin" ]] {
    # virt-manager 普通用户
    LIBVIRT_DEFAULT_URI="qemu:///system"

    # 添加 $HOME/.local/bin 到 PATH
    PATH=$PATH:$HOME/.local/bin
}
