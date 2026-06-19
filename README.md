# dev-flakes

Sammlung von Nix-Flake-Templates für reproduzierbare Entwicklungsumgebungen. Jedes Template stellt eine fertige `devShell` mit den relevanten Tools für die jeweilige Sprache bzw. den Anwendungsfall bereit.

Inspiriert von [the-nix-way/dev-templates](https://github.com/the-nix-way/dev-templates).

## Voraussetzungen

- [Nix](https://nixos.org/download) mit aktivierten Flakes
- Optional: [direnv](https://direnv.net/) für automatisches Laden der Shell

## Verwendung

### Einmaliger Start (ohne direnv)

```bash
nix flake init -t github:blckr/dev-flakes#<template>
nix develop
```

### Mit direnv (empfohlen)

Die Templates enthalten bereits eine `.envrc` mit `use flake`. Nach dem Init reicht:

```bash
nix flake init -t github:blckr/dev-flakes#<template>
direnv allow
```

Die Entwicklungsumgebung wird dann automatisch beim Betreten des Verzeichnisses aktiviert.

## Templates

| Name | Alias | Inhalt |
|------|-------|--------|
| `c` | `cpp` | clang-tools, cmake, conan, cppcheck, doxygen, gtest, lcov, vcpkg, gdb |
| `go` | – | Go 1.26, gopls, golangci-lint, delve, gotools, gcc |
| `rust` | – | rustc, cargo, rust-analyzer, rustfmt, clippy, gdb |
| `python` | – | Python 3.13, venv-Hook, pip |
| `java` | – | JDK 23, Maven, Gradle, Lombok |
| `kotlin` | – | Kotlin + JDK 23, Gradle |
| `jupyter` | – | Python 3.11, ipykernel, Poetry (für Skripte/Notebooks) |
| `jupyter-notebook` | – | JupyterLab, ipywidgets, ipympl, jupyterlab-git, Node.js |
| `typst` | – | typst, tinymist, typstyle, pandoc |
| `typst-rotis` | – | wie `typst`, zusätzlich Rotis-Schrift (LUH-Netz) |
| `linux-full` | `linux` | LLVM/Clang 18, QEMU, guestfs-tools, gdb – Linux-Kernel-Entwicklung |
| `linux-llvm` | – | LLVM/Clang 18, QEMU, gdb, Linux-Kernel-Quellen als `inputsFrom` |
| `linux-hx` | – | Helix-Konfiguration (languages.toml) für Kernel-Entwicklung |
| `platformio` | – | PlatformIO, clang-tools, cmake, conan, cppcheck, gdb |

## Linux-Kernel-Entwicklung

Das `linux-full`-Template enthält ein `meta/`-Verzeichnis mit Justfile, NixOS-VM-Konfiguration und Kernel-Config-Vorlagen für x86 und arm64.

```bash
nix flake init -t github:blckr/dev-flakes#linux
# Linux-Repository nach /linux klonen
make nconfig          # Kernel konfigurieren
just gen-compile-commands
just make
just qemu             # VM starten (Login: root oder eval)
```

Für Helix-Editor-Support im Kernel-Verzeichnis:

```bash
nix flake init -t github:blckr/dev-flakes#linux-hx
```

## Python-Version anpassen

Im `python`-Template kann die Python-Version oben in der `flake.nix` geändert werden:

```nix
version = "3.13";  # auf gewünschte Version setzen
```

Nach der Änderung `.venv` löschen und Shell neu laden.

## Go-Version anpassen

Im `go`-Template die Versionsnummer am Anfang der `flake.nix` ändern:

```nix
goVersion = 26;  # entspricht go_1_26
```
