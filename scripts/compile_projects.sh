#!/bin/bash
set -e

echo "Compiling Rust projects..."
echo "Building hw_sim..."
(cd hw_sim && cargo build --release)

echo "Building kiwi_hw_control/gc..."
(cd kiwi_hw_control/gc && cargo build --release)

echo "Compilation complete."
