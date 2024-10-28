{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    
    # Your identity
    userName = "netlooker";
    userEmail = "netlooker@outlook.be";

    # Basic settings
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      
      # Core settings
      core = {
        editor = "code --wait";
        autocrlf = "input";      # Convert CRLF to LF on commit
        whitespace = "trailing-space,space-before-tab";
      };

      # Colors and UI
      color = {
        ui = "auto";
      };

      # Better diffs
      diff = {
        algorithm = "patience";   # Better diffs for code
        colorMoved = "default";   # Color moved lines differently
      };

      # Pull/Push behavior
      pull = {
        rebase = true;           # Rebase instead of merge on pull
      };
      push = {
        default = "current";     # Push current branch to upstream
        autoSetupRemote = true;  # Automatically set upstream
      };

      # Better merge conflict resolution
      merge = {
        conflictStyle = "diff3"; # Show common ancestor in conflicts
      };

      # Helpful aliases
      alias = {
        st = "status";
        ci = "commit";
        co = "checkout";
        br = "branch";
        unstage = "reset HEAD --";
        last = "log -1 HEAD";
        visual = "!gitk";
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };

      # URL shortcuts for your commonly used repositories
      url = {
        "git@github.com:" = {
          insteadOf = "gh:";
        };
      };
    };

    # Git ignores that apply globally
    ignores = [
      # macOS specific
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"
      
      # VSCode
      ".vscode"
      "*.code-workspace"
    ];

    # Git delta for better diffs (optional but recommended)
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "Dracula";
        side-by-side = true;
      };
    };
  };
}