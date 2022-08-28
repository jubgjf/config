# ==========            ==========
# ========== 一些 alias ==========
# ==========            ==========

# fzf
FZF_DEFAULT_COMMAND="fd --type f --exclude .git --exclude node_modules --exclude __pycache__ --exclude venv"
alias fzf="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' --height 60%"

# ls
alias ls="exa"
alias ll="exa --icons -l --octal-permissions --git"
alias la="exa --icons -l --octal-permissions --git -a"
alias l2="exa --icons -l --octal-permissions --git -T --level=2"
alias l3="exa --icons -l --octal-permissions --git -T --level=3"
alias tree="exa --icons -T"

# cd (zoxide)
alias cd="z"

# mv, cp (rsync)
alias cp="rsync -pogbraz --info=progress2 -hhh"
alias rmv="rsync -pogbraz --info=progress2 -hhh --remove-source-files"

# latex
alias xelatex="docker run -it -v miktex:/miktex/.miktex -v "$(pwd)":/miktex/work miktex/miktex xelatex"
alias bibtex="docker run -it -v miktex:/miktex/.miktex -v "$(pwd)":/miktex/work miktex/miktex bibtex"

# 其他
alias cat="bat"
alias top="htop"
alias r='ranger --choosedir=$XDG_CACHE_HOME/rangerdir; LASTDIR=$(cat $XDG_CACHE_HOME/rangerdir); cd "$LASTDIR"'
alias unzipw="unzip -O cp936"
alias grep="rga"
alias q="exit"
alias windows="xfreerdp /u:Administrator /v:192.168.122.69 /dynamic-resolution /bpp:24 /network:lan /gdi:hw +home-drive +clipboard +aero"
