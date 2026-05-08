#!/bin/bash
set -e

# Function to check if a package is installed
is_installed() {
    if [ -f /etc/debian_version ]; then
        dpkg -s "$1" >/dev/null 2>&1
    elif [ -f /etc/fedora-release ]; then
        rpm -q "$1" >/dev/null 2>&1
    else
        return 1
    fi
}

# Check for essential tools
MISSING_DEPS=0
for tool in gcc make pkg-config git; do
    if ! command -v $tool >/dev/null 2>&1; then
        MISSING_DEPS=1
        break
    fi
done

# Check for libssl/openssl-devel (heuristic)
if [ -f /etc/debian_version ]; then
    if ! dpkg -s libssl-dev >/dev/null 2>&1; then MISSING_DEPS=1; fi
elif [ -f /etc/fedora-release ]; then
    if ! rpm -q openssl-devel >/dev/null 2>&1; then MISSING_DEPS=1; fi
fi

if [ $MISSING_DEPS -eq 0 ]; then
    echo "System dependencies are already installed. Skipping sudo."
    exit 0
fi

echo "Installing missing system dependencies..."
if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
        ubuntu|debian)
            sudo apt update && sudo apt install -y build-essential pkg-config libssl-dev git
            ;;
        fedora)
            sudo dnf groupinstall -y "Development Tools" && sudo dnf install -y openssl-devel pkgconf-pkg-config git
            ;;
        *)
            echo "Unsupported OS: $ID. Please install build-essential, pkg-config, and openssl-dev manually."
            exit 1
            ;;
    esac
fi
