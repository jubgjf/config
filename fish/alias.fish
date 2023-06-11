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

switch (hostname)
case "*MacBook*"
case "*"
    alias top "htop"
    alias unzipw "unzip -O cp936"
    alias r 'ranger --choosedir=$XDG_CACHE_HOME/rangerdir; set LASTDIR $(cat $XDG_CACHE_HOME/rangerdir); cd "$LASTDIR"'
end
