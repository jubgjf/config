# ========== ls ==========

alias ls="lsd"
alias ll="lsd -l"
alias la="lsd -lA"


# ========== 其他 ==========

alias cd="z"
alias cp="rsync -az --progress"
alias vim="nvim"
alias cat="bat"
alias grep="rga"
alias q="exit"
alias r='ranger --choosedir=$XDG_CACHE_HOME/rangerdir; LASTDIR=$(cat $XDG_CACHE_HOME/rangerdir); cd "$LASTDIR"'
alias top="htop"
alias unzipw="unzip -O cp936"


# ========== slurm ==========

if [[ "$(uname -n)" == hpc-login* || "$(uname -n)" == gpu* || "$(uname -n)" == mngg001 || "$(uname -n)" == g400* || "$(uname -n)" == ln01 ]] {
  alias sq='squeue -o "%5i %9P %10j %10u %10T %10M %12l %6D %7R %b" -u $USER'
  alias si='sinfo -N -o "%5N  %5t  %13C  %8O  %8e  %7m  %G"'
  alias sa='sacct -X --format="JobID%6, State%10, JobName%15, Elapsed%10, AllocTRES%80"'
} else {
  sq() {
    ssh scir-01 'squeue -o "%5i %9P %10j %10u %10T %10M %12l %6D %7R %b" -u $USER'
  }
  si() {
    ssh scir-01 'sinfo -N -o "%5N  %5t  %13C  %8O  %8e  %7m  %G"'
  }
  sa() {
    ssh scir-01 'sacct -X --format="JobID%6, State%10, JobName%15, Elapsed%10, AllocTRES%80"'
  }
  alias sw="ssh scir scir-watch"
}
