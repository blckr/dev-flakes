{
  description = "Jupyter-Flake by blckr";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, ... }@inputs:

    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        f:
        inputs.nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            pkgs = import inputs.nixpkgs { inherit system; };
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            venvDir = ".venv";
            packages =
              with pkgs;
              [
                poetry
                python311
              ]
              ++ (with python311Packages; [
                jupyter
                notebook
                jupyterlab
                ipykernel
                pip
                venvShellHook
              ]);
            
            JUPYTER_CONFIG_DIR = ".jupyter";
            JUPYTER_DATA_DIR = ".jupyter/share";
            JUPYTER_RUNTIME_DIR = ".jupyter/runtime";
            
            JUPYTERLAB_SETTINGS_DIR = ".jupyter/lab/user-settings";
            JUPYTERLAB_SCHEMAS_DIR = ".jupyter/lab/schemas";
            
            shellHook = ''
              unset PYTHONPATH
              
              mkdir -p .jupyter/lab/user-settings
              mkdir -p .jupyter/lab/schemas
              mkdir -p .jupyter/runtime
              
              echo ""
              echo " -------- Starting Jupyter Notebook --------"
              echo "jupyter notebook --NotebookApp.token='' <filename>"
              echo ""
            '';
          };
        }
      );
    };
}
