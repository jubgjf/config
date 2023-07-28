# fzf
set FZF_DEFAULT_COMMAND "fd --type f --exclude .git --exclude node_modules --exclude __pycache__ --exclude venv --exclude wandb"
alias fzf "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' --height 60%"

# ls
alias ls "lsd"
alias ll "lsd -l"
alias la "lsd -lA"

alias cd "z"
alias cp "rsync -az --progress"
alias vim "nvim"
alias cat "bat"
alias grep "rga"
alias q "exit"
alias r 'ranger --choosedir=$XDG_CACHE_HOME/rangerdir; LASTDIR=$(cat $XDG_CACHE_HOME/rangerdir); cd "$LASTDIR"'
alias top "htop"
alias unzipw "unzip -O cp936"

switch (hostname)
case "hpc-login*" "gpu*" "ln01"
    alias sq 'squeue -o "%.4i %.9P %.10j %.10u %.10T %.10M %.12l %.6D %7R %b" -u $USER'
    alias si 'sinfo -N -o "%5N  %5t  %13C  %8O  %8e  %7m  %G"'
    alias sa 'sacct -X --format="JobID%6, State%10, JobName%15, Elapsed%10, AllocTRES%80"'
case "*"
end
