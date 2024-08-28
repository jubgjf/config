# ========== 别名 ==========

alias ls="lsd --color auto"
alias ll="lsd -lh --color auto"
alias la="lsd -lh -A --color auto"
alias cp="rsync -azP"
alias vim="nvim"
alias view="nvim -R"
alias cat="bat"
alias grep="rga"
alias q="exit"
alias top="htop"
alias unzipw="unzip -O cp936"
alias ze="zellij"
alias diff="delta -s"

# ========== 自定义函数 ==========

function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# ========== slurm ==========

set uname (uname -n)
if string match -qr "^hpc-login|gpu|dmx|g400|ln01|g00" $uname
    alias sq='squeue -o "%7i %10P %10u %24j %10T %12M %12l %6D %12R %8m %8c %b" --me'
    alias squ='squeue -o "%7i %10P %10u %24j %10T %12M %12l %6D %12R %8m %8c %b"'
    alias si='sinfo -N -o "%5N  %5t  %13C  %8O  %8e  %7m  %G"'
    alias sa='sacct -X --format="JobID%6, State%10, JobName%15, Elapsed%10, AllocTRES%80"'
end
