{ config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    mutableExtensionsDir = false;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      catppuccin.catppuccin-vsc
    ];
    userSettings = {
      # Font settings
      "editor.fontFamily" = "'FiraCode Nerd Font', 'Fira Code', Menlo, Monaco, 'Courier New', monospace";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 12;
      
      # Terminal settings
      "terminal.integrated.fontFamily" = "FiraCode Nerd Font";
      "terminal.integrated.fontSize" = 10;
      "terminal.integrated.defaultLocation" = "editor";  # Forces terminal into editor area
      "terminal.integrated.showInTabs" = true;          # Ensures terminal appears in the editor tabs
      "terminal.integrated.defaultProfile.osx" = "fish";
      # Terminal settings
      "terminal.integrated.profiles.osx" = {
        "fish" = {
          "path" = "${pkgs.fish}/bin/fish";
          "args" = [ "--login" "--init-command" "clear; set fish_greeting" ];  # Clear history messages and screen
        };
      };
      
      # Prevent terminal from reopening automatically on restart
      "terminal.integrated.enablePersistentSessions" = false;

      # Explicitly disable panel mode
      "terminal.integrated.tabs.enabled" = true;
      "workbench.panel.defaultLocation" = "bottom";

      # Window settings
      "window.newWindowDimensions" = "fullscreen";
      "window.restoreFullscreen" = true;
      "window.titleBarStyle" = "native";
      
      # Workspace settings
      "workbench.startupEditor" = "none";
      "workbench.commandPalette.experimental.suggestCommands" = true;

      # Editor Group Layout
      "workbench.editor.enablePreview" = false;        # Prevents temporary editor tabs
      
      # Theme settings
      "workbench.colorTheme" = "Catppuccin Mocha";
      "catppuccin.accentColor" = "mauve";

      # Update settings
      "update.mode" = "none";
      "extensions.autoUpdate" = false;
      "extensions.autoCheckUpdates" = false;
    };
  };
}
