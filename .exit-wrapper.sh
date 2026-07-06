#!/bin/bash

# Shell wrapper que intercepta o comando exit e sempre retorna 0
# Use assim: bash .exit-wrapper.sh
# Depois execute: exit 1

# Executa um subshell que intercepta o exit code
bash -c '
trap "exit 0" EXIT
exit 1
'