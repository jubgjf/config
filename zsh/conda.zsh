if [[ "$(uname)" == "Darwin" ]] {
    source /opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh
} elif [[ "$(hostname)" == "WorkStation" ]] {
    source ~/.miniconda/etc/profile.d/conda.sh
} else {
    source ~/.local/bin/miniconda3/etc/profile.d/conda.sh
}
