# ==========            ==========
# ========== 一些 alias ==========
# ==========            ==========

# fzf
FZF_DEFAULT_COMMAND="fd --type f --exclude .git --exclude node_modules --exclude __pycache__ --exclude venv"
alias fzf="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' --height 60%"

# ls
alias ls="lsd"
alias ll="lsd -l"
alias la="lsd -lA"

# cd (zoxide)
alias cd="z"

# cp (rsync)
alias cp="rsync -az --progress --delete"

# 其他
alias vim="nvim"
alias cat="bat"
alias grep="rga"
alias q="exit"

if [[ "$(uname)" != "Darwin" ]] {
    alias r='ranger --choosedir=$XDG_CACHE_HOME/rangerdir; LASTDIR=$(cat $XDG_CACHE_HOME/rangerdir); cd "$LASTDIR"'
    alias top="htop"
    alias unzipw="unzip -O cp936"
}
