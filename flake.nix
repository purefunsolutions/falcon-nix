{
  description = "falcon-nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }: let
    lib = nixpkgs.lib;
    systems = with flake-utils.lib.system; [
      x86_64-linux
    ];
  in
    # Combine list of attribute sets together
    lib.foldr lib.recursiveUpdate {} [
      (flake-utils.lib.eachSystem systems (system: let
        # pkgs = nixpkgs.legacyPackages.${system};
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            cudaSupport = true;
          };
          overlays = [
            (final: prev: {
              python3 = prev.python3.override {
                packageOverrides = finalP: prevP: {
                  # TODO: Use binary torch for now, because package compiled
                  #       from source has problem finding CUDA libraries at
                  #       runtime.
                  torch = prevP.torch-bin;
                };
              };
              python3Packages = final.python3.pkgs;
            })
          ];
        };
      in {
        packages.rouge = pkgs.callPackage ./rouge.nix {
          pythonPackages = pkgs.python3Packages;
        };
        packages.auto_gptq = pkgs.callPackage ./auto_gptq.nix {
          pythonPackages = pkgs.python3Packages;
          rouge = self.packages.${system}.rouge;
        };

        packages.falcon = pkgs.callPackage ./falcon.nix {
          auto_gptq = self.packages.${system}.auto_gptq;
          pythonPackages = pkgs.python3Packages;
        };

        packages.default = self.packages.${system}.falcon;

        formatter = pkgs.alejandra;
      }))
    ];
}
