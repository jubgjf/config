# ========== conda ==========

if [[ "$(uname)" == "Darwin" ]] {
  . /opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh
} elif [[ "$(uname -n)" == "surfacebook3" ]] {
  . /opt/miniconda/etc/profile.d/conda.sh
} elif [[ "$(uname -n)" == paraai* ]] {
  . /home/bingxing2/apps/anaconda/2021.11/etc/profile.d/conda.sh
} else {
  . $HOME/.miniconda/etc/profile.d/conda.sh
}
