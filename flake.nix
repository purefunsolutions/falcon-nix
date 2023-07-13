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
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.falcon = pkgs.callPackage ./falcon.nix {};

        packages.default = self.packages.${system}.falcon;

        formatter = pkgs.alejandra;
      }))
    ];
}
