{ inputs }:

{ modules, role, system }:
inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {
    inherit inputs role;
  };
  modules = modules ++ [
    ./args.nix
    ./common.nix
  ];
}
