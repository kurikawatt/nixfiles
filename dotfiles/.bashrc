#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export GPG_TTY=$(tty)
export EDITOR=nvim

export FLAKE="~/git/nixfiles"
export MAGLA_BUILDSYS="nh"
export MAGLA_TEMPLATES_DIR="~/.templates"


alias ls="ls --color=auto"
alias ll="ls -lh"

alias grep="grep --color=auto"

alias py="python3"

PS1='\[\e[0;36m\](\W) \[\e[1;34m\]\u\[\e[1;33m\]@\h\[\e[0m\]\$ '
