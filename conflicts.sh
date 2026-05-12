#!/usr/bin/env bash
# conflicts.sh -- Known config file conflict paths
# Sourced by install.sh. Do not execute directly.
#
# CONFLICT_<NAME>_PATHS: array of paths that may conflict with the managed
# config for <NAME>. Paths use ${HOME} etc., expanded at runtime.

CONFLICT_GIT_PATHS=('${HOME}/.gitconfig')

CONFLICT_CONDA_PATHS=('${HOME}/.condarc')

CONFLICT_ALACRITTY_PATHS=('${HOME}/.alacritty.toml' '${HOME}/.alacritty.yml')

CONFLICT_ZSH_PATHS=('${HOME}/.zshenv' '${HOME}/.zprofile')

# macOS-only; checked conditionally at runtime
CONFLICT_PIP_PATHS=('${HOME}/Library/Application Support/pip/pip.conf')
