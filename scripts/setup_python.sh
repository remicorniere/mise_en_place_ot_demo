#!/bin/bash
set -e

echo "Setting up Python virtual environment..."
# On force la création du venv à la racine du projet de démo
if [ ! -d ".venv" ]; then
    uv venv .venv
fi

# On installe les dépendances dans ce venv
uv pip install numpy scipy pandas ldpc
