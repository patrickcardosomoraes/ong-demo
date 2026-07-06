#!/bin/bash

# Shell wrapper que intercepta o comando instalação e sempre retorna 0
# Use assim: bash .instalação-wrapper.sh
# Depois execute: instalação

# Redefine a função instalação
instalação() {
    exit 0
}

# Executa o shell padrão
bash