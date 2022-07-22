# ========== 一些路径变量 ==========

CONFIG_HOME=$HOME/code/config
source $CONFIG_HOME/zsh/zsh/env.zsh

# ========== 符号链接路径对应表 ==========

declare -A path_map
path_map=(
    $CONFIG_HOME/alacritty                          $XDG_CONFIG_HOME/alacritty
    $CONFIG_HOME/clang/clang-format/_clang-format   $HOME/.clang-format
    $CONFIG_HOME/clang/clangd                       $XDG_CONFIG_HOME/clangd
    $CONFIG_HOME/fcitx5/_config                     $XDG_CONFIG_HOME/fcitx5
    $CONFIG_HOME/fcitx5/_pam_environment            $HOME/.pam_environment
    $CONFIG_HOME/git/git                            $XDG_CONFIG_HOME/git
    $CONFIG_HOME/git/gpg/gpg-agent.conf             $HOME/.gnupg/gpg-agent.conf
    $CONFIG_HOME/neofetch                           $XDG_CONFIG_HOME/neofetch
    $CONFIG_HOME/npm                                $XDG_CONFIG_HOME/npm
    $CONFIG_HOME/python/conda/condarc               $HOME/.conda/condarc
    $CONFIG_HOME/python/pip                         $XDG_CONFIG_HOME/pip
    $CONFIG_HOME/ranger                             $XDG_CONFIG_HOME/ranger
    $CONFIG_HOME/vim/ideavim                        $XDG_CONFIG_HOME/ideavim
    $CONFIG_HOME/vim/neovim                         $XDG_CONFIG_HOME/nvim
    $CONFIG_HOME/wget/wgetrc                        $XDG_CONFIG_HOME/wgetrc
    $CONFIG_HOME/zsh/starship/starship.toml         $XDG_CONFIG_HOME/starship.toml
)


# ========== 对配置文件进行符号链接 ==========

success=0
skip=0
fail=0

for k v (${(kv)path_map}) {
    echo "\x1b[1;0m"
    echo "[${k#$CONFIG_HOME/}]"
    echo "尝试进行符号链接 $k -> $v"

    if [[ -L $v && -e $v ]] {
        # good link

        echo "\x1b[1;34m符号链接已存在，跳过"
        skip=$(($skip + 1))

    } elif [[ -L $v && ! -e $v ]] {
        # broken link

        echo "\x1b[1;35m符号链接已失效，进行覆盖"
        rm $v
        ln -s $k $v

        if [[ -L $v && -e $v ]] {
            echo "\x1b[1;32m成功!"
            success=$(($success + 1))
        } else {
            echo "\x1b[1;31m失败!"
            fail=$(($fail + 1))
        }

    } elif [[ -e $v ]] {
        # not a link

        echo "\x1b[1;36m文件或目录已存在，跳过"
        skip=$(($skip + 1))

    } else {
        # missing

        ln -s $k $v

        if [[ -L $v && -e $v ]] {
            echo "\x1b[1;32m成功!"
            success=$(($success + 1))
        } else {
            echo "\x1b[1;31m失败!"
            fail=$(($fail + 1))
        }
    }
}

# ========== 一些单独的配置 ==========

# packer
echo "\x1b[1;0m"
echo "[packer]"
NVIM_PACKER_DIR=$XDG_DATA_HOME/nvim/site/pack/packer/start/packer.nvim
if [[ ! -d $NVIM_PACKER_DIR ]] {
    git clone --depth 1 https://github.com/wbthomason/packer.nvim $NVIM_PACKER_DIR

    if [[ ! -L $v && -e $v ]] {
        echo "\x1b[1;32m成功!"
        success=$(($success + 1))
    } else {
        echo "\x1b[1;31m失败!"
        fail=$(($fail + 1))
    }
} else {
    echo "\x1b[1;34mpacker 已存在，跳过"
    skip=$(($skip + 1))
}

# ranger
RANGER_PLUGINS_DIR=$XDG_CONFIG_HOME/ranger/plugins
echo "\x1b[1;0m"
echo "[ranger plugin - devicons2]"
if [[ ! -d $RANGER_PLUGINS_DIR/devicons2 ]] {
    git clone https://github.com/cdump/ranger-devicons2 $RANGER_PLUGINS_DIR/devicons2

    if [[ ! -L $v && -e $v ]] {
        echo "\x1b[1;32m成功!"
        success=$(($success + 1))
    } else {
        echo "\x1b[1;31m失败!"
        fail=$(($fail + 1))
    }
} else {
    echo "\x1b[1;34mranger plugin - devicons2 已存在，跳过"
    skip=$(($skip + 1))
}
echo "\x1b[1;0m"
echo "[ranger plugin - zoxide]"
if [[ ! -d $RANGER_PLUGINS_DIR/zoxide ]] {
    git clone https://github.com/jchook/ranger-zoxide.git $RANGER_PLUGINS_DIR/zoxide

    if [[ ! -L $v && -e $v ]] {
        echo "\x1b[1;32m成功!"
        success=$(($success + 1))
    } else {
        echo "\x1b[1;31m失败!"
        fail=$(($fail + 1))
    }
} else {
    echo "\x1b[1;34mranger plugin - zoxide 已存在，跳过"
    skip=$(($skip + 1))
}

# ========== 总结结果 ==========

total=$(($success + $skip + $fail))

echo "\x1b[1;0m"
echo ""
printf "成功 [%02d / %02d] 个\n" $success $total
printf "跳过 [%02d / %02d] 个\n" $skip    $total
printf "失败 [%02d / %02d] 个\n" $fail    $total
