{
  description = "NixOS configuration with Home Manager for multiple profiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
  let
    hosts = [ "desktop" "air" ];  # Define all host names here
    primary-user = "shiva";  # Define the primary user here
  in
  {
    nixosConfigurations = nixpkgs.lib.attrsets.genAttrs hosts (host: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/${host}/configuration.nix
        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModules.home-manager
      ];
      specialArgs = {
        inherit inputs primary-user;
      };
    });
  };
}


