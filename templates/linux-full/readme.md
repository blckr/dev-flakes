Original Code: [luhsra/srapkgs](https://github.com/luhsra/srapkgs/blob/master/templates/linux/)

# Linux Setup inside of NixOS

Quickstart:
- clone the linux-repository into the folder `/linux`
- go into `/linux` and execute `make nconfig` or `make defconfig` to build the config
- execute `just gen-compile-commands` to get language-server support
- execute `just make` to build the linux-kernel

- execute `just qemu` to start the vm
  - log in via `root` or `eval`

**Recommendation:** Use the Helix Editor
For language support and the correct formatting go into the `/linux` directory and execute the following command:
- `nix flake init -t github:blckr/dev-flakes/linux-hx`
