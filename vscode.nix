{ config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    mutableExtensionsDir = false;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      # Nix
      jnoortheen.nix-ide

      # Essential Markdown support
      yzhang.markdown-all-in-one    # Swiss army knife for Markdown (>4M installations)
      davidanson.vscode-markdownlint # Markdown linting (>2M installations)
      
      # Theme and basic editing
      catppuccin.catppuccin-vsc    # Our theme
      
      # YAML/TOML for Hugo config files
      redhat.vscode-yaml           # YAML support (>3M installations)
    ];
    userSettings = {
      # Font settings
      "editor.fontFamily" = "'FiraCode Nerd Font', 'Fira Code', Menlo, Monaco, 'Courier New', monospace";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 14;
      
      # Markdown settings specifically for Hugo
      "[markdown]" = {
        "editor.defaultFormatter" = "yzhang.markdown-all-in-one";
        "editor.formatOnSave" = true;
        "editor.wordWrap" = "on";
        "editor.rulers" = [ 80 ];
        "editor.unicodeHighlight.ambiguousCharacters" = false;
        "editor.unicodeHighlight.invisibleCharacters" = false;
        "editor.stickyScroll.enabled" = true;
      };
      
      # Hugo-specific file associations
      "files.associations" = {
        "*.html" = "html";
        "layouts/**/*.html" = "gohtml";
        "*.md" = "markdown";
      };

      # Markdown lint settings (Hugo-friendly)
      "markdownlint.config" = {
        "MD013" = false;         # Line length
        "MD024" = false;         # Multiple headers with same content
        "MD033" = false;         # Allow inline HTML
        "MD041" = false;         # First line in file should be h1
      };
      
      # Preview settings
      "markdown.preview.breaks" = true;
      "markdown.preview.doubleClickToSwitchToEditor" = true;

      # File explorer settings
      "explorer.fileNesting.enabled" = true;
      "explorer.fileNesting.patterns" = {
        "*.md" = "\${capture}.*.md";
        "config.toml" = "config.*.toml,params.toml";
      };

      # Terminal settings
      "terminal.integrated.fontFamily" = "FiraCode Nerd Font";
      "terminal.integrated.fontSize" = 12;
      "terminal.integrated.defaultLocation" = "editor";  # Forces terminal into editor area
      "terminal.integrated.showInTabs" = true;          # Ensures terminal appears in the editor tabs
      "terminal.integrated.defaultProfile.osx" = "fish";
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
