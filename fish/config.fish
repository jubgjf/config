if status is-interactive
    # Commands to run in interactive sessions can go here

    # 取消一开始的问候
    set fish_greeting

    # config 总目录
    set CONFIG_HOME $HOME/code/config

    # source 一下 fish 的其他配置
    source $CONFIG_HOME/fish/conda.fish
    source $CONFIG_HOME/fish/env.fish
    starship init fish | source
    zoxide init fish | source
    source $CONFIG_HOME/fish/alias.fish # 对 cd 的别名需要放在 zoxide init 后边
end
