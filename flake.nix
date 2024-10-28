{
  description = "Netlooker's home-manager Config for Old Intel-based Mac";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgsAllowUnfree = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      homeConfigurations."netlooker" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsAllowUnfree;  # Use the config with allowUnfree
        modules = [ ./home.nix ];
      };
    };
}
