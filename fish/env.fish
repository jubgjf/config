# ==========                    ==========
# ========== XDG Base Directory ==========
# ==========                    ==========

# XDG
set XDG_CONFIG_HOME $HOME/.config
set XDG_CACHE_HOME $HOME/.cache
set XDG_DATA_HOME $HOME/.local/share
set XDG_STATE_HOME $HOME/.local/state

# ==========              ==========
# ========== other export ==========
# ==========              ==========

# xz 用尽可能多核进行压缩
set XZ_OPT "-T0"

# GPG 签名
set GPG_TTY $(tty)

# 默认编辑器
set VISUAL nvim
set EDITOR nvim

# 一些 bin 文件路径
set PATH $PATH:$HOME/.local/bin

switch (hostname)
case "*MacBook*"
case "hpc-server"
case "WorkStation"
case "gpu*"
case "*"
    # virt-manager 普通用户
    set LIBVIRT_DEFAULT_URI "qemu:///system"
end
