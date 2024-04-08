# ========== conda ==========

if [[ "$(uname -n)" == "WorkStation" ]] {
  . /opt/miniconda/etc/profile.d/conda.sh
} elif [[ "$(uname)" != "Darwin" ]] {
  . $HOME/.miniconda/etc/profile.d/conda.sh
}
