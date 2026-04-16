#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export GPG_TTY=$(tty)
export EDITOR=nvim

export FLAKE="~/git/nixfiles"
export MAGLA_TEMPLATES_DIR="~/.templates"


alias ls="ls --color=auto"
alias ll="ls -lh"

alias grep="grep --color=auto"

alias ssh="kitten ssh"

alias py="python3"

PS1='(\W) \[\e[32m\]\u\[\e[33m\]@\h\[\e[0m\]$ '
