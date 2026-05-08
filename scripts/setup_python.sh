#!/bin/bash
set -e

echo "Setting up Python virtual environment..."
[ ! -d ".venv" ] && uv venv
uv pip install numpy scipy pandas ldpc
