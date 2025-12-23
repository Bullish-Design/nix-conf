{
  description = "Home Manager configuration of andrew";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nixvim = {
        url = "github:nix-community/nixvim";
        # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
        inputs.nixpkgs.follows = "nixpkgs";
    };

    IDE.url = "github:Bullish-Design/IDE";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    # # Latest rust version: 
    # nixpkgs-rust190 = {
    #   url = "github:NyCodeGHG/nixpkgs/rust-1-90-0";
    #   # This is a fork, so we don't follow the main nixpkgs input
    # };
  };

  outputs = inputs@{ nixpkgs, home-manager, nixvim, IDE, nixCats, ... }: #PyNui, , nixpkgs-rust190

  { 
    nixosConfigurations = {
      framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          
          { _module.args = { inherit inputs; }; }

          # make home-manager as a module of nixos so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.andrew = import ./home.nix;
            
            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
              extraSpecialArgs = {
              inherit inputs;
            };
            };
          }
        ];
      };
    };
  };
}
