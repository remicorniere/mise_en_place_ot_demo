# Oblivious Transfer Demo Setup

This project provides a fully automated environment to run the VeriQloud Oblivious Transfer (OT) demo using [mise](https://mise.jdx.dev/). It manages multiple projects, languages (Rust, Python), and real-time log visualization with [Zellij](https://zellij.dev/).

## Prerequisites

- **Linux** (Ubuntu/Debian or Fedora recommended).
- **mise** installed. [Follow the installation guide](https://mise.jdx.dev/getting-started.html).
- **sudo** privileges (required only once to install system dependencies like `build-essential` and `libssl-dev`).

### Important: mise shell hook
To benefit from the **automatic environment activation** (where your terminal automatically uses the correct Python version and virtual environment when you enter this directory), ensure you have configured the `mise` shell hook.

Add the following to your shell configuration (e.g., `~/.bashrc` or `~/.zshrc`):
```bash
# For Bash
eval "$(mise activate bash)"
# For Zsh
eval "$(mise activate zsh)"
```

## Quick Start

1. **Clone this repository**:
   ```bash
   git clone <this-repo-url>
   cd mise_en_place_ot_demo
   ```

1(bis). **Run the full setup** (optional: the next step will run this too anyway):
   This command installs system dependencies (prompts for sudo), clones the sub-projects at the correct version (`forumquantiquedefense`), patches known bugs, and compiles everything.
   ```bash
   mise run setup
   ```

3. **Launch the demo**:
   This opens a Zellij session with all components starting in order (Simulator -> GC -> OT/QBER App) with a 1-second delay between each.
   ```bash
   # Normal OT run (Error logs only)
   mise demo

   # OT run with Debug logs
   mise demo_debug

   # QBER demo run
   mise demo_qber
   ```


## Manual Usage & Development

If you prefer to run or debug components manually, the environment is pre-configured for you:

- **Automatic venv**: Once you enter the directory, your `python` command automatically points to the local `.venv`. You can run Python scripts directly:
  ```bash
  python applications_on_qline/Q_oblivious_transfer/server_run.py ...
  ```
- **Rust Toolchain**: The correct version of Rust is automatically active. You can go into any sub-folder and run `cargo build` or `cargo test`.

## Project Components

The setup automatically manages and patches the following:
- `hw_sim`: Quantum hardware simulator (specifically the `forumquantiquedefense` version).
- `kiwi_hw_control`: Hardware control layer (specifically the `gc` module).
- `applications_on_qline`: The Oblivious Transfer application layer.

## Troubleshooting

- **Permissions**: If the `setup` task fails during system dependency installation, ensure you have `sudo` access.
- **IPC Errors**: If the simulator logs `failed to fill whole buffer`, it usually means the `gc` component crashed or isn't running. Use `mise demo_debug` to see more details.
- **Manual Cleanup**: To reset the environment completely, you can delete the sub-folders and the `.venv` directory, then run `mise run setup` again.
