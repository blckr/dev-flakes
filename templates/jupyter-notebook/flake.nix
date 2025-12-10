{
  description = "Jupyter Dev-Flake by blckr";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        
        # Create Python environment with JupyterLab and extensions
        pythonEnv = pkgs.python3.withPackages (ps: with ps; [
          jupyterlab
          ipykernel
          ipywidgets
          notebook
          jupyterlab-git
          ipympl
        ]);

      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pythonEnv
            pkgs.nodejs
          ];

          shellHook = ''
            echo "JupyterLab environment ready!"
            echo ""
            echo "Start with: jupyter lab"
          '';
        };
      }
    );
}

