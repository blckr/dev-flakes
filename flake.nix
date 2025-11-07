{
  description = "Flakes for Dev-Env by blckr";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: let
    supportedSystems = [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    pkgs = forAllSystems (system: import nixpkgs {
      inherit system; overlays = [ self.overlays.default ];
    });
  in {
    templates = nixpkgs.lib.genAttrs [
      "rust"
    ] (name : {
      path = ./templates/${name};
      description = (import ./templates/${name}/flake.nix).description;
    });
  };
}
