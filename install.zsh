# ========== 一些路径变量 ==========

CONFIG_HOME=$HOME/code/config
source $CONFIG_HOME/zsh/zsh/env.zsh

# ========== 符号链接路径对应表 ==========

declare -A path_map
path_map=(
    $CONFIG_HOME/git/git/config             $HOME/.gitconfig
    $CONFIG_HOME/git/gpg/gpg-agent.conf     $HOME/.gnupg/gpg-agent.conf
    $CONFIG_HOME/python/conda/condarc       $HOME/.conda/condarc
    $CONFIG_HOME/vim/ideavim/ideavimrc      $HOME/.ideavimrc
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


# ========== 总结结果 ==========

total=$(($success + $skip + $fail))

echo "\x1b[1;0m"
echo ""
printf "成功 [%02d / %02d] 个\n" $success $total
printf "跳过 [%02d / %02d] 个\n" $skip    $total
printf "失败 [%02d / %02d] 个\n" $fail    $total
