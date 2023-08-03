# ========== conda ==========

if [[ "$(uname)" == "Darwin" ]] {
  source /opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh
} elif [[ "$(uname -n)" == "surfacebook3" ]] {
  source /opt/miniconda/etc/profile.d/conda.sh
} else {
  source $HOME/.miniconda/etc/profile.d/conda.sh
}
