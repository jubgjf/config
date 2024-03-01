# ========== conda ==========

if [[ "$(uname)" == "Darwin" ]] {
  . /opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh
} elif [[ "$(uname -n)" == "WorkStation" ]] {
  . /opt/miniconda/etc/profile.d/conda.sh
} else {
  . $HOME/.miniconda/etc/profile.d/conda.sh
}
