{ config, lib, pkgs, ... }:
{
  # Shell Prompt
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      format = "$username$hostname$shlvl$singularity$kubernetes$directory$git_branch$git_commit$git_state$git_status$hg_branch$docker_context$package$cmake$dart$dotnet$elixir$elm$erlang$golang$helm$java$julia$nim$nodejs$ocaml$perl$php$purescript$python$ruby$rust$swift$terraform$zig$nix_shell$conda$memory_usage$aws$gcloud$env_var$crystal$cmd_duration$custom$line_break$jobs$battery$time$status$character";

      scan_timeout = 30;
      add_newline = true;

      # Define palette first
      palette = "catppuccin_mocha";
      palettes.catppuccin_mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };

      aws = {
        disabled = false;
        format = "on [$symbol$profile(\\($region\\))]($style) ";
        symbol = " ";
        style = "bold yellow";
      };

      battery = {
        disabled = false;
        full_symbol = "";
        charging_symbol = "";
        discharging_symbol = "";
        format = "[$symbol$percentage]($style) ";
        display = [{
          threshold = 10;
          style = "bold red";
        }];
      };

      character = {
        disabled = false;
        format = "$symbol ";
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vicmd_symbol = "[❮](bold green)";
      };

      directory = {
        disabled = false;
        truncation_length = 3;
        truncate_to_repo = true;
        fish_style_pwd_dir_length = 0;
        use_logical_path = true;
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "bold mauve";
        read_only = "";
        read_only_style = "bold red";
        truncation_symbol = "";
      };

      git_branch = {
        disabled = false;
        format = "on [$symbol$branch]($style) ";
        symbol = " ";
        style = "bold pink";
        truncation_symbol = "…";
      };

      git_commit = {
        disabled = false;
        commit_hash_length = 7;
        format = "[\\($hash\\)]($style) ";
        style = "bold green";
        only_detached = true;
      };

      git_state = {
        disabled = false;
        rebase = "REBASING";
        merge = "MERGING";
        revert = "REVERTING";
        cherry_pick = "CHERRY-PICKING";
        bisect = "BISECTING";
        am = "AM";
        am_or_rebase = "AM/REBASE";
        style = "bold yellow";
        format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
      };

      git_status = {
        disabled = false;
        format = "([\\[$all_status$ahead_behind\\]]($style) )";
        style = "bold red";
        stashed = "\\$";
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇕";
        conflicted = "=";
        deleted = "✘";
        renamed = "»";
        modified = "!";
        staged = "+";
        untracked = "?";
      };

      hostname = {
        disabled = false;
        ssh_only = true;
        trim_at = ".";
        format = "[$hostname]($style) in ";
        style = "bold blue";
      };

      nodejs = {
        disabled = false;
        format = "via [$symbol$version]($style) ";
        symbol = " ";
        style = "bold green";
      };

      python = {
        disabled = false;
        format = "via [$symbol$version]($style) ";
        style = "bold yellow";
        symbol = " ";
      };

      rust = {
        disabled = false;
        format = "via [$symbol$version]($style) ";
        symbol = " ";
        style = "bold red";
      };

      time = {
        disabled = true;
        format = "at [$time]($style) ";
        style = "bold yellow";
        time_format = "";
      };

      username = {
        disabled = false;
        format = "[$user]($style) in ";
        style_root = "bold red";
        style_user = "bold lavender";
        show_always = true;
      };
    };
  };
}
