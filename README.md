# dev-flakes

A collection of Nix flake templates for reproducible development environments. Each template provides a ready-to-use `devShell` with the relevant tools for the respective language or use case.

Inspired by [the-nix-way/dev-templates](https://github.com/the-nix-way/dev-templates).

## Prerequisites

- [Nix](https://nixos.org/download) with flakes enabled
- Optional: [direnv](https://direnv.net/) for automatic shell loading

## Usage

### One-time start (without direnv)

```bash
nix flake init -t github:blckr/dev-flakes#<template>
nix develop
```

### With direnv (recommended)

The templates already include an `.envrc` with `use flake`. After init, just run:

```bash
nix flake init -t github:blckr/dev-flakes#<template>
direnv allow
```

The development environment will then be activated automatically when entering the directory.

## Templates

| Name | Alias | Contents |
|------|-------|----------|
| `c` | `cpp` | clang-tools, cmake, conan, cppcheck, doxygen, gtest, lcov, vcpkg, gdb |
| `go` | – | Go 1.26, gopls, golangci-lint, delve, gotools, gcc |
| `rust` | – | rustc, cargo, rust-analyzer, rustfmt, clippy, gdb |
| `python` | – | Python 3.13, venv hook, pip |
| `java` | – | JDK 23, Maven, Gradle, Lombok |
| `kotlin` | – | Kotlin + JDK 23, Gradle |
| `jupyter` | – | Python 3.11, ipykernel, Poetry (for scripts/notebooks) |
| `jupyter-notebook` | – | JupyterLab, ipywidgets, ipympl, jupyterlab-git, Node.js |
| `typst` | – | typst, tinymist, typstyle, pandoc |
| `typst-rotis` | – | like `typst`, additionally includes Rotis font (LUH network) |
| `linux-full` | `linux` | LLVM/Clang 18, QEMU, guestfs-tools, gdb – Linux kernel development |
| `linux-llvm` | – | LLVM/Clang 18, QEMU, gdb, Linux kernel sources as `inputsFrom` |
| `linux-hx` | – | Helix configuration (languages.toml) for kernel development |
| `platformio` | – | PlatformIO, clang-tools, cmake, conan, cppcheck, gdb |

## Linux Kernel Development

The `linux-full` template includes a `meta/` directory with a Justfile, NixOS VM configuration, and kernel config templates for x86 and arm64.

```bash
nix flake init -t github:blckr/dev-flakes#linux
# Clone the Linux repository to /linux
make nconfig          # Configure the kernel
just gen-compile-commands
just make
just qemu             # Start the VM (login: root or eval)
```

For Helix editor support in the kernel directory:

```bash
nix flake init -t github:blckr/dev-flakes#linux-hx
```

## Changing the Python Version

In the `python` template, the Python version can be changed at the top of `flake.nix`:

```nix
version = "3.13";  # set to desired version
```

After the change, delete `.venv` and reload the shell.

## Changing the Go Version

In the `go` template, change the version number at the beginning of `flake.nix`:

```nix
goVersion = 26;  # corresponds to go_1_26
```
