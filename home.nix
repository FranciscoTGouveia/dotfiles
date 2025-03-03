{ config, pkgs, lib, ... }:

{
  home.username = "francisco";
  home.homeDirectory = "/home/francisco";
   

  # Git
  programs.git = {
    enable = true;
    userName = "FranciscoTGouveia";
    userEmail = "francisco.t.gouveia@tecnico.ulisboa.pt";
    extraConfig = {
      color.ui = true;
      pull.rebase = true;
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
    diff-so-fancy = { enable = true; };
  };


  # Alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window = {
        opacity = 0.5;
      };
      font = {
        size = 7;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
      shell.program = "${pkgs.zsh}/bin/zsh";
    };
  };


  # Bash
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    autocd = true;
    shellAliases = {
      lg = "lazygit";
      nv = "nvim";
      ll = "ls -lh";
      hades = "ssh francisco@85.138.35.238";
      sound = "pavucontrol";
      tmux = "tmux -T RGB";
      ":q" = "exit";
      aquila-start = "sshfs ftg@aquila.inesc-id.pt:/home/ftg/z3 ~/z3";
      aquila-end = "fusermount -u ~/z3";
    };
    oh-my-zsh = {
        enable = true;
        theme = "bira";
        plugins = [ "git" "sudo" "aliases" "rust" "python" "ssh" "tmux"];
      };
  };

  # Tmux
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    clock24 = true;
    customPaneNavigationAndResize = true;
    keyMode = "vi";
    newSession = true;
    mouse = true;
  };

  # i3
  xsession.windowManager.i3 = {
    enable = true;
    config = rec {
      modifier = "Mod4";

      window = {
        border = 0;
        titlebar = false;
      };

      gaps = {
        inner = 5;
        outer = 5;
      };

      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+b" = "exec ${pkgs.brave}/bin/brave";
        "${modifier}+space" = "exec ${pkgs.rofi}/bin/rofi -show drun";
        "${modifier}+x" = "exec ${pkgs.i3lock-fancy}/bin/i3lock-fancy";
        "${modifier}+q" = "kill";
	      "${modifier}+p" = "exec ${pkgs.flameshot}/bin/flameshot gui";
      };

      startup = [
        {
	        command = "${pkgs.feh}/bin/feh --bg-scale ${config.home.homeDirectory}/dotfiles/wallpaper.png";
          always = true;
          notification = false;
        }
        {
          command = "${pkgs.networkmanagerapplet}/bin/nm-applet}";
          always = true;
          notification = false;
        }
        {
          command = "xset r rate 190 75";
          always = true;
          notification = false;
        }
      ];
    };
  };

  # Rofi
  programs.rofi = {
    enable = true;
    theme = builtins.toFile "tokyo-night.rasi" ''
      * {
        bg0     : #1a1b26;
        bg1     : #1f2335;
        bg2     : #24283b;
        bg3     : #414868;
        fg0     : #c0caf5;
        fg1     : #a9b1d6;
        fg2     : #737aa2;
        red     : #f7768e;
        green   : #9ece6a;
        yellow  : #e0af68;
        blue    : #7aa2f7;
        magenta : #9a7ecc;
        cyan    : #4abaaf;

        accent: @red;
        urgent: @yellow;

        background-color : transparent;
        text-color       : @fg0;

        margin  : 0;
        padding : 0;
        spacing : 0;
      }

      element-icon, element-text, scrollbar {
        cursor: pointer;
      }

      window {
        location : center;
        width    : 40%;
        border: 2px;
        border-color: @bg3;
        border-radius: 10px;
        background-color: @bg1;
      }

      inputbar {
        spacing  : 10px;
        padding  : 8px;
        children : [ icon-search, entry ];
        background-color: @bg0;
      }

      icon-search, entry, element-icon, element-text {
        vertical-align: 0.5;
      }

      icon-search {
        expand   : false;
        filename : "search-symbolic";
        size     : 18px;
      }

      textbox {
        padding          : 8px;
        background-color : @bg2;
      }

      listview {
        padding      : 8px;
        lines        : 10;
        columns      : 1;
        scrollbar    : true;
        fixed-height : false;
        dynamic      : true;
      }

      element {
        padding : 8px;
        spacing : 10px;
      }

      element normal urgent {
        text-color: @urgent;
      }

      element normal active {
        text-color: @accent;
      }

      element alternate active {
        text-color: @accent;
      }

      element selected {
        text-color       : @bg1;
        background-color : @accent;
      }

      element selected urgent {
        background-color: @urgent;
      }

      element-text {
        text-color: inherit;
      }

      scrollbar {
        handle-width : 6px;
        handle-color : @fg2;
        padding      : 0 6px;
      }
    '';

    extraConfig = {
      modi = "drun,run";
      show-icons = true;
      terminal = "alacritty";
    };
  };

  # Picom
  services.picom = {
    enable = true;
    vSync = true;

    settings = {
      backend = "glx";
      blur = {
        method = "guassian";
        size = 20;
        deviation = 5.0;
      };
      corner-radius = 15;  # Change this for more or less rounding
      round-borders = 1;
      shadow = true;
      shadow-radius = 10;
      shadow-opacity = 0.2; # Transparency of shadows
      blur-background = true;
      blur-background-frame = true;
      blur-background-fixed = true;
      blur-strength = 5;
      experimental-backends = true;
    };
  };
  
  home.stateVersion = "24.05";
  # Let home-manager install and manage itself.
  programs.home-manager.enable = true;
}
