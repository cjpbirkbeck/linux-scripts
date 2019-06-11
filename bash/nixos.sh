#!/usr/bin/env bash
# This script automates working with nixos-rebuild
# Christopher Birkbeck

sub="$1"
# shift 1
# rest="$@"

case $sub in
    edit|config|ed|conf)
        nixos-rebuild edit
        ;;
    switch|boot|test|build|dry-build|dry-activate|build-vm|build-vm-with-bootloader)
        nixos-rebuild "$@"
        ;;
    option|op|query)
        nixos-option "$@"
        ;;
    --version|-v|version)
        nixos-version
        ;;
    variables|vars)
        if [[ -z $NIXOS_CONFIG ]]; then
            echo "\$NIXOS_CONFIG is not set; default to /etc/nixos/configuration.nix."
            echo "nixos edit will use the default editor ${VISUAL}."
        else
            echo "\$NIXOS_CONFIG is set to ${NIXOS_CONFIG}."
            echo "nixos edit will use the default editor ${VISUAL}."
        fi
        echo "\$NIX_SSHOPTS is set to ${NIX_SSHOPTS}."
        ;;
    help|--help|-?)
        man nixos-rebuild
        ;;
    *)
        exit 1
        ;;
esac
