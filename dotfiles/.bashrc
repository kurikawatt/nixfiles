#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export GPG_TTY=$(tty)

alias nu="sudo nixos-rebuild --flake ~/git/nixfiles/ switch"
alias nfu="sudo bash ~/scripts/nixos-full-update.sh"
alias nd="~/scripts/ndd.sh"
alias nbiso="nix run nixpkgs#nixos-generators -- --format iso --flake ~/git/nixfiles#iso -o result"

alias ls="ls --color=auto"
alias ll="ls -lh"

alias grep="grep --color=auto"

alias ssh="kitten ssh"

alias py="python3"

PS1='(\W$(__git_ps1 "~%s")) \[\e[32m\]\u\[\e[33m\]@\h\[\e[0m\]$ '
