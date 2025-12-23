{ inputs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.andrew = import ../home.nix;

    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
