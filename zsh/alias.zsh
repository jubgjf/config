alias cd="z"
alias cp="rsync -azP"
alias vim="nvim"
alias view="nvim -R"
alias cat="bat"
alias grep="rga"
alias q="exit"
alias j='EDITOR=nvim VISUAL=nvim joshuto --output-file $XDG_CACHE_HOME/joshutodir; LASTDIR=`cat $XDG_CACHE_HOME/joshutodir`; cd "$LASTDIR"'
alias top="htop"
alias unzipw="unzip -O cp936"
alias ze="zellij"
alias diff="delta -s"


# ========== slurm ==========

if [[ "$(uname -n)" == hpc-login* || "$(uname -n)" == gpu* || "$(uname -n)" == mngg* || "$(uname -n)" == g400* || "$(uname -n)" == ln01 || "$(uname -n)" == g000* ]] {
  alias sq='squeue -o "%7i %10P %24j %10T %12M %12l %6D %12R %b" -u $USER'
  alias si='sinfo -N -o "%5N  %5t  %13C  %8O  %8e  %7m  %G"'
  alias sa='sacct -X --format="JobID%6, State%10, JobName%15, Elapsed%10, AllocTRES%80"'
}
