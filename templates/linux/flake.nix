{
  description = "Linux-Flake by blckr";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      supportedSystems = [ "x86_64-linux" ];
      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            pkgs = import nixpkgs {
              inherit system;
            };
          }
        );
    in
    {
      # Dev shell for the whole project (excluding kernel compilation).
      devShells = forEachSupportedSystem (
        { pkgs }:
        let
          dev_pkgs = with pkgs; [
            # (clang-tools.override { enableLibcxx = true; })
            clang-tools
            bear
            gdb
            gnumake
            just
            qemu_kvm
          ];
        in
        {
          default =
            pkgs.mkShell.override
              {
                # Use clang with libcxx, the only stdlib where std::format is
                # fully implemented
                # stdenv = pkgs.libcxxStdenv;
                stdenv = pkgs.clangStdenv;
              }
              {
                hardeningDisable = [ "all" ];
                packages = dev_pkgs;
              };
        }
      );
    };
}
