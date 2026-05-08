#!/bin/bash
set -e

echo "Checking/Cloning projects..."

# Projects requiring 'forumquantiquedefense'
for proj in kiwi_hw_control hw_sim; do
    if [ ! -d "$proj" ]; then
        echo "Cloning $proj..."
        git clone https://github.com/Veriqloud/$proj.git
    fi
    echo "Setting $proj to version 'forumquantiquedefense'..."
    (cd $proj && git fetch origin && git checkout forumquantiquedefense)
done

# OT Project (default branch)
if [ ! -d "applications_on_qline" ]; then
    echo "Cloning applications_on_qline..."
    git clone https://github.com/Veriqloud/applications_on_qline.git
fi
