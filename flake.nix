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
    
    loadDescription = templateName: (import ./templates/${templateName}/flake.nix).description;
    
  in {
    templates = nixpkgs.lib.genAttrs [
      "c"
      "go"
      "java"
      "jupyter"
      "jupyter-notebook"
      "kotlin"
      "linux-llvm"
      "platformio"
      "python"
      "rust"
      "typst"
      "typst-rotis"
    ] (name : {
      path = ./templates/${name};
      description = loadDescription name;
    }) // {
      # Aliases
      cpp = {
        path = ./templates/c;
        description = loadDescription "c";
      };
      linux = {
        path = ./templates/linux-llvm;
        description = loadDescription "linux-llvm";
      };
    };
  };
}
