#!/usr/bin/env bash
# config.sh -- Dotfiles registry
# Sourced by install.sh. Do not execute directly.

CONFIG_ENTRIES=(
  alacritty
  conda
  fcitx5
  fish
  git
  gpg
  ideavim
  joshuto
  lsd
  neofetch
  neovim
  pip
  ranger
  rye
  starship
  uv
  vscodevim
  yazi
  zellij
  zsh
)

# ── Per-entry definitions ──────────────────────────────────
# CFG_<NAME>_SRC / CFG_<NAME>_TGT
# Single-quoted: ${VAR} tokens expanded at runtime via eval.

CFG_ALACRITTY_SRC='${CONFIG_HOME}/alacritty'
CFG_ALACRITTY_TGT='${XDG_CONFIG_HOME}/alacritty'

CFG_CONDA_SRC='${CONFIG_HOME}/conda/condarc'
CFG_CONDA_TGT='${HOME}/.conda/condarc'

CFG_FCITX5_SRC='${CONFIG_HOME}/fcitx5'
CFG_FCITX5_TGT='${XDG_CONFIG_HOME}/fcitx5'

CFG_FISH_SRC='${CONFIG_HOME}/fish'
CFG_FISH_TGT='${XDG_CONFIG_HOME}/fish'

CFG_GIT_SRC='${CONFIG_HOME}/git'
CFG_GIT_TGT='${XDG_CONFIG_HOME}/git'

CFG_GPG_SRC='${CONFIG_HOME}/gpg'
CFG_GPG_TGT='${HOME}/.gnupg'

CFG_IDEAVIM_SRC='${CONFIG_HOME}/ideavim'
CFG_IDEAVIM_TGT='${XDG_CONFIG_HOME}/ideavim'

CFG_JOSHUTO_SRC='${CONFIG_HOME}/joshuto'
CFG_JOSHUTO_TGT='${XDG_CONFIG_HOME}/joshuto'

CFG_LSD_SRC='${CONFIG_HOME}/lsd'
CFG_LSD_TGT='${XDG_CONFIG_HOME}/lsd'

CFG_NEOFETCH_SRC='${CONFIG_HOME}/neofetch'
CFG_NEOFETCH_TGT='${XDG_CONFIG_HOME}/neofetch'

CFG_NEOVIM_SRC='${CONFIG_HOME}/neovim'
CFG_NEOVIM_TGT='${XDG_CONFIG_HOME}/nvim'

CFG_PIP_SRC='${CONFIG_HOME}/pip'
CFG_PIP_TGT='${XDG_CONFIG_HOME}/pip'

CFG_RANGER_SRC='${CONFIG_HOME}/ranger'
CFG_RANGER_TGT='${XDG_CONFIG_HOME}/ranger'

CFG_RYE_SRC='${CONFIG_HOME}/rye/config.toml'
CFG_RYE_TGT='${HOME}/.rye/config.toml'

CFG_STARSHIP_SRC='${CONFIG_HOME}/starship/starship.toml'
CFG_STARSHIP_TGT='${XDG_CONFIG_HOME}/starship.toml'

CFG_UV_SRC='${CONFIG_HOME}/uv'
CFG_UV_TGT='${XDG_CONFIG_HOME}/uv'

CFG_VSCODEVIM_SRC='${CONFIG_HOME}/vscodevim/vscodevimrc'
CFG_VSCODEVIM_TGT='${HOME}/.vscodevimrc'

CFG_YAZI_SRC='${CONFIG_HOME}/yazi'
CFG_YAZI_TGT='${XDG_CONFIG_HOME}/yazi'

CFG_ZELLIJ_SRC='${CONFIG_HOME}/zellij'
CFG_ZELLIJ_TGT='${XDG_CONFIG_HOME}/zellij'

CFG_ZSH_SRC='${CONFIG_HOME}/zsh/zshrc'
CFG_ZSH_TGT='${HOME}/.zshrc'

# ── Host-specific overrides ────────────────────────────────
# CFG_<NAME>_HOSTS: space-separated list of hostnames (OTHERS = fallback)
# CFG_<NAME>_HOST_<SANITIZED_HOSTNAME>_SRC / _TGT: paths relative to CFG_<NAME>_SRC

CFG_GPG_HOSTS='JiannanMacBook-Air.local'
CFG_GPG_HOST_JIANNANMACBOOK_AIR_LOCAL_SRC='gpg-agent-mac.conf'
CFG_GPG_HOST_JIANNANMACBOOK_AIR_LOCAL_TGT='gpg-agent.conf'

CFG_IDEAVIM_HOSTS='JiannanMacBook-Air.local OTHERS'
CFG_IDEAVIM_HOST_JIANNANMACBOOK_AIR_LOCAL_SRC='ideavimrc-mac'
CFG_IDEAVIM_HOST_JIANNANMACBOOK_AIR_LOCAL_TGT='ideavimrc'
CFG_IDEAVIM_HOST_OTHERS_SRC='ideavimrc-common'
CFG_IDEAVIM_HOST_OTHERS_TGT='ideavimrc'
