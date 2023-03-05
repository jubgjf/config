# ==========            ==========
# ========== 一些 alias ==========
# ==========            ==========

# fzf
FZF_DEFAULT_COMMAND="fd --type f --exclude .git --exclude node_modules --exclude __pycache__ --exclude venv --exclude wandb"
alias fzf="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' --height 60%"

# ls
alias ls="lsd"
alias ll="lsd -l"
alias la="lsd -lA"

alias cd="z"
alias cp="rsync -az --progress --delete"
alias vim="nvim"
alias cat="bat"
alias grep="rga"
alias q="exit"

if [[ "$(uname)" != "Darwin" ]] {
    alias r='ranger --choosedir=$XDG_CACHE_HOME/rangerdir; LASTDIR=$(cat $XDG_CACHE_HOME/rangerdir); cd "$LASTDIR"'
    alias top="htop"
    alias unzipw="unzip -O cp936"
}

if [[ "$(hostname)" == "hpc-server" || "$(hostname)" == gpu* ]] {
    alias sq='squeue -o "%.i %.9P %.10j %.10u %.10T %.10M %.12l %.6D %R" -u $USER'
    alias git="~/.local/bin/miniconda3/envs/binary/bin/git"
    unalias grep
    unalias vim
    alias vim="~/.local/bin/nvim"
}

if [[ "$(hostname)" == "hpc-server" ]] {
    unalias vim
    unalias cat
}
