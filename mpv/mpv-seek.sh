#!/usr/bin/env bash
# Describe script here.
# Created on Wednesday December 05, 2018.
# Created by Christopher Birkbeck

echo "{ \"command\": [ \"seek\", \"${1}\" ] }" | socat - /tmp/mpvsocket
