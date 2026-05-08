#!/bin/bash
set -e

echo "Applying fixes and redirections..."

# 1. Fix typo in hw_sim
if [ -f "hw_sim/configs/src/ipc/mod.rs" ]; then
    sed -i 's/decoy_delay\\t100/decoy_fiber_delay\\t100/g' hw_sim/configs/src/ipc/mod.rs
    echo "Fixed decoy_delay typo in hw_sim."
fi

# 2. Align BATCHSIZE in gc
if [ -f "kiwi_hw_control/gc/src/hw.rs" ]; then
    sed -i 's/pub const BATCHSIZE: usize = 256;/pub const BATCHSIZE: usize = 1024;/g' kiwi_hw_control/gc/src/hw.rs
    echo "Aligned BATCHSIZE in kiwi_hw_control/gc."
fi

# 3. Redirect Cargo dependencies to local path
if [ -f "hw_sim/Cargo.toml" ]; then
    sed -i 's|gc = { git = "ssh://git@github.com/Veriqloud/kiwi_hw_control.git", branch = "master" }|gc = { path = "../kiwi_hw_control/gc" }|' hw_sim/Cargo.toml
    rm -f hw_sim/Cargo.lock
    echo "Redirected hw_sim dependencies to local paths."
fi

# 4. Create log directory
mkdir -p applications_on_qline/Q_oblivious_transfer/log
