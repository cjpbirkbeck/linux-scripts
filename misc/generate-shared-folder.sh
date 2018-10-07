#!/usr/bin/env bash
# Creates the shared folders used for VirtualBox hosts.
# Created on Sunday October 07, 2018.
# Created by Christopher Birkbeck

if [[ ! -d $HOME/Shared ]]; then
  mkdir "$HOME/Shared"
fi

for vm in "$@"; do
  mkdir "$HOME/Shared/$vm"  "$HOME/Shared/To/$vm"  "$HOME/Shared/From/$vm"  "$HOME/Shared/Among/$vm"  "$HOME/Shared/$vm"

  cd "$HOME/Shared/$vm" || { exit 1; }

  ln --symbolic "$HOME/Shared/To/$vm" Outbox
  ln --symbolic "$HOME/Shared/From/$vm" Inbox
  ln --symbolic "$HOME/Shared/Among/$vm" Bidirectional
done
