{
  config,
  lib,
  pkgs,
  ...
}: let
  dendron-extensions = with pkgs.vscode-utils; extensionsFromVscodeMarketplace [
    {
      name = "dendron";
      publisher = "dendron";
      version = "0.124.0";
      sha256 = "sha256-/hxgmmiMUfBtPt5BcuNvtXs3LzDmPwDuUOyDf2udHws=";
    }
    {
      name = "dendron-paste-image";
      publisher = "dendron";
      version = "1.1.1";
      sha256 = "sha256-SlW8MEWBgf8cJsdSzeegqPiAlEvlnrxuvrJJdhHwq2E=";
    }
    {
      name = "dendron-markdown-shortcuts";
      publisher = "dendron";
      version = "0.12.1";
      sha256 = "sha256-Kmjm1xQvrt228XNSRkLUu6Yu3Oec4csJhi74zjsh3HY=";
    }
  ];
in {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;  # Now we can lock this down!
    extensions = with pkgs.vscode-extensions; [
      # Nix
      jnoortheen.nix-ide

      # Essential Markdown support
      yzhang.markdown-all-in-one
      davidanson.vscode-markdownlint

      # Theme and basic editing
      catppuccin.catppuccin-vsc

      # YAML/TOML for Hugo config files
      redhat.vscode-yaml
      tamasfe.even-better-toml

      jkillian.custom-local-formatters
    ] ++ dendron-extensions;
    userSettings = {
      # Font settings
      "editor.fontFamily" = "'FiraCode Nerd Font', 'Fira Code', Menlo, Monaco, 'Courier New', monospace";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 16;

      # Dendron-specific settings
      "dendron.rootDir" = "~/dendron";
      "dendron.defaultLookupCreateBehavior" = "selectionExtract";
      "dendron.enableSelfContainedVaultWorkspace" = true;

      "[nix]" = {
        "editor.defaultFormatter" = "jkillian.custom-local-formatters";
        "files.trimTrailingWhitespace" = true;
      };

      "customLocalFormatters.formatters" = [
        {
          "command" = "${lib.getExe pkgs.nixfmt-rfc-style} \${file}";
          "languages" = [ "nix" ];
        }
      ];
      "nix.formatterPath" = lib.getExe pkgs.nixfmt-rfc-style;

      # Markdown settings specifically for Hugo
      "[markdown]" = {
        "editor.defaultFormatter" = "yzhang.markdown-all-in-one";
        "editor.formatOnSave" = true;
        "editor.wordWrap" = "on";
        "editor.rulers" = [ 80 ];
        "editor.unicodeHighlight.ambiguousCharacters" = false;
        "editor.unicodeHighlight.invisibleCharacters" = false;
        "editor.stickyScroll.enabled" = true;
        "editor.snippetSuggestions" = "inline";
        "files.trimTrailingWhitespace" = true;
      };

      # Hugo-specific file associations
      "files.associations" = {
        "*.html" = "html";
        "layouts/**/*.html" = "gohtml";
        "*.md" = "markdown";
      };

      # Markdown lint settings (Hugo-friendly)
      "markdownlint.config" = {
        "MD013" = false; # Line length
        "MD024" = false; # Multiple headers with same content
        "MD033" = false; # Allow inline HTML
        "MD041" = false; # First line in file should be h1
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

      "[toml]" = {
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "tamasfe.even-better-toml";
      };

      # Editor enhancements
      "editor.bracketPairColorization.enabled" = true;
      "editor.guides.bracketPairs" = true;
      "editor.suggest.showStatusBar" = true;
      "editor.inlineSuggest.enabled" = true;
      "editor.formatOnSave" = true;
      "editor.renderWhitespace" = "boundary";
      "editor.rulers" = [ 80 120 ];

      # Terminal settings
      "terminal.integrated.fontFamily" = "FiraCode Nerd Font";
      "terminal.integrated.fontSize" = 14;
      "terminal.integrated.defaultLocation" = "editor"; # Forces terminal into editor area
      "terminal.integrated.defaultProfile.osx" = "fish";
      "terminal.integrated.profiles.osx" = {
        "fish" = {
          "path" = "${pkgs.fish}/bin/fish";
          "args" = [
            "--login"
            "--init-command"
            "clear; set fish_greeting"
          ]; # Clear history messages and screen
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
      "workbench.editor.enablePreview" = false; # Prevents temporary editor tabs

      # Theme settings
      "workbench.colorTheme" = "Catppuccin Mocha";
      "catppuccin.accentColor" = "mauve";

      # Update settings
      "update.mode" = "none";
      "extensions.autoUpdate" = false;
      "extensions.autoCheckUpdates" = false;

      # Search settings
      "search.useIgnoreFiles" = true;
      "search.exclude" = {
        "**/node_modules" = true;
        "**/.dendron.cache.*" = true;
      };

      # Performance optimizations
      "files.watcherExclude" = {
        "**/.git/objects/**" = true;
        "**/.git/subtree-cache/**" = true;
        "**/node_modules/**" = true;
        "**/.dendron.cache.*" = true;
      };

      # Ensure consistent line endings
      "files.eol" = "\n";

      # Whitespace handling
      "files.trimTrailingWhitespace" = true;
      "files.trimFinalNewlines" = true;
      "files.insertFinalNewline" = true;

    };
  };
}
