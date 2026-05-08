#!/bin/bash
set -e

echo "Applying fixes and redirections..."

# 1. Align BATCHSIZE in gc and qber to 1024 (hw_sim uses 1024)
if [ -f "kiwi_hw_control/gc/src/hw.rs" ]; then
    sed -i 's/pub const BATCHSIZE: usize = 256;/pub const BATCHSIZE: usize = 1024;/g' kiwi_hw_control/gc/src/hw.rs
    echo "Aligned BATCHSIZE in kiwi_hw_control/gc to 1024."
fi
if [ -f "kiwi_hw_control/qber/src/lib.rs" ]; then
    sed -i 's/pub const BATCHSIZE: usize = 256;/pub const BATCHSIZE: usize = 1024;/g' kiwi_hw_control/qber/src/lib.rs
    echo "Aligned BATCHSIZE in kiwi_hw_control/qber to 1024."
fi

# 2. Redirect Cargo dependencies to local path
if [ -f "hw_sim/Cargo.toml" ]; then
    sed -i 's|gc = { git = "ssh://git@github.com/Veriqloud/kiwi_hw_control.git", branch = "master" }|gc = { path = "../kiwi_hw_control/gc" }|' hw_sim/Cargo.toml
    rm -f hw_sim/Cargo.lock
    echo "Redirected hw_sim dependencies to local paths."
fi

# 3. Fix Python UnboundLocalError in client_run.py
if [ -f "applications_on_qline/Q_oblivious_transfer/client_run.py" ]; then
    sed -i 's/except:/except Exception as e:/g' applications_on_qline/Q_oblivious_transfer/client_run.py
    echo "Fixed UnboundLocalError in applications_on_qline/Q_oblivious_transfer/client_run.py"
fi

# 4. Create log directory
mkdir -p applications_on_qline/Q_oblivious_transfer/log
