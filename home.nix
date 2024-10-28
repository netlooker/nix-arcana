{ config, pkgs, ... }: {
  home.username = "netlooker";
  home.homeDirectory = "/Users/netlooker";
  home.stateVersion = "24.05";

  imports = [
    ./starship.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    catppuccin
  ];

  programs = {
    # Terminal
    fish = {
      enable = true;
      interactiveShellInit = ''
        # Set catppuccin theme if it exists
        if test -f ~/.config/fish/themes/Catppuccin\ Mocha.theme
          fish_config theme save "Catppuccin Mocha"
        end
      '';
      shellAliases = {
        # Home Manager alias
        "hm" = "home-manager switch --flake ~/.config/nix-config";
        # LazyGit alias
        "lg" = "lazygit";
      };
    };

    # Git utilities
    lazygit = {
      enable = true;
    };

    # Home Manager
    home-manager = {
      enable = true;
    };
  };
}
