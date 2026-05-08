#!/bin/bash
# Usage: ./scripts/set_log_level.sh [Debug|Error|Info]
LEVEL=$1
if [ -z "$LEVEL" ]; then
    echo "Usage: $0 [Debug|Error|Info]"
    exit 1
fi

echo "Setting log_level to $LEVEL in all config files..."
# On remplace n'importe quelle valeur de log_level par celle demandée
find hw_sim/config_files -name "*.json" -exec sed -i "s/\"log_level\": \"[^\"]*\"/\"log_level\": \"$LEVEL\"/g" {} +
