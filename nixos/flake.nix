{

  description = "nixos";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    # nix-ld 
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    # nix-index
    #nix-index-database.url = "github:nix-community/nix-index-database";
    #nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nix-ld, nixpkgs, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        # unstable = nixpkgs-unstable.legacyPackages.${prev.system};
        # use this variant if unfree packages are needed:
        unstable = import nixpkgs-unstable {
          inherit system;
          # Allow unfree packages
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [
              "electron-24.8.6"
              "electron-25.9.0"
            ];
          };
        };

      };
    in
    {
      nixosConfigurations = {
        inherit system; # inherit the system declared

        bladestealth = nixpkgs.lib.nixosSystem {
          modules = [
            # Overlays-module makes "pkgs.unstable" available in configuration.nix
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = [
                overlay-unstable
              ];
            })

            nix-ld.nixosModules.nix-ld
            #nix-index-database.nixosModules.nix-index

            ./systems/bladestealth
          ];
        };

        potatovault = nixpkgs.lib.nixosSystem {
          modules = [

            ({ config, pkgs, ... }: {
              nixpkgs.overlays = [
                overlay-unstable
              ];
            })

            ./systems/potatovault

          ];
        };
      };

    };

}
