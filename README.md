# Mise en place Oblivious Transfer demo

Scripts to setup an environment to be able to run the Oblivious Transfer (OT) demo. 
This project uses [mise](https://mise.jdx.dev/) to manage tool versions (Rust, Python, Zellij, uv) and automate the setup of multiple interconnected projects.

## Prerequisites

- **Linux** (Ubuntu/Debian or Fedora recommended)
- **mise** installed on your system. [Installation guide](https://mise.jdx.dev/getting-started.html)
- **sudo** privileges (required once to install system dependencies like `build-essential` and `libssl-dev`)

## Quick Start

1. **Clone this repository** (if you haven't already):
   ```bash
   git clone <this-repo-url>
   cd mise_en_place_ot_demo
   ```

2. **Install tools and setup the environment**:
   This command will install the required versions of Rust, Python, Zellij, and uv, then it will install system dependencies, clone the sub-projects, and compile the Rust binaries.
   ```bash
   mise install
   mise run setup
   ```

3. **Run the demo**:
   This will launch a [Zellij](https://zellij.dev/) session with all components (Simulator, GC, and OT Application) running in separate panes for real-time log viewing.
   ```bash
   mise demo
   ```

## Project Structure

The setup automatically manages the following projects:
- `hw_sim`: Quantum hardware simulator.
- `kiwi_hw_control`: Hardware control layer (specifically the `gc` module).
- `applications_on_qline`: The Oblivious Transfer application.

## Troubleshooting

- **System dependencies**: If you are not on Ubuntu or Fedora, the `setup` task might fail to install system libraries. Please manually install `build-essential`, `pkg-config`, `openssl-dev`, and `git`.
- **Zellij Layout**: The demo is configured to run in a Zellij session. If you prefer running without Zellij, you will need to manually execute the commands defined in `demo-layout.kdl`.
