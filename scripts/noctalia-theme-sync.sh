#!/usr/bin/env bash

if [[ $1 == "true" ]]; then
  dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
else
  dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
fi
