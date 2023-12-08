{

  description = "nixos";

  inputs = {
    # nixpkgs - shorthand
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = nixpkgs-unstable.legacyPackages.${prev.system};
        # use this variant if unfree packages are needed:
        # unstable = import nixpkgs-unstable {
        #   inherit system;
        #   config.allowUnfree = true;
        # };

      };
    in
    {
      nixosConfigurations = {
        inherit system; # inherit the system declared

        # specify system
        nixos = nixpkgs.lib.nixosSystem {
          modules = [
            # Overlays-module makes "pkgs.unstable" available in configuration.nix
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
            ./configuration.nix
            #./razer/blade-stealth/2021/nvidia-drivers
          ];
        };
      };

    };

}
