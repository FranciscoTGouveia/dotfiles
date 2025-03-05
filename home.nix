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
        inner = 3;
        outer = 8;
      };

      bars = [];

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
        {
          command = "${pkgs.polybarFull}/bin/polybar main";
          always = true;
          notification = true;
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

  services.polybar = {
    enable = true;
    script = "polybar main &";
    config = {
      "bar/main" = {
        width = "100%";
        height = 30;
        radius = 6;
        fixed-center = true;
        
        background = "#1a1b26cc";
        foreground = "#c0caf5";
        
        line-size = 3;
        line-color = "#7aa2f7";
        
        border-size = 0;
        border-color = "#00000000";
        
        padding-left = 2;
        padding-right = 2;
        
        module-margin-left = 1;
        module-margin-right = 1;
        
        font-0 = "JetBrainsMono Nerd Font:style=Medium:size=10;2";
        font-1 = "JetBrainsMono Nerd Font:style=Bold:size=10;2";
        font-2 = "JetBrainsMono Nerd Font:size=12;2";
        
        modules-left = "i3";
        modules-center = "date";
        modules-right = "filesystem pulseaudio memory cpu wlan battery";
        
        tray-position = "right";
        tray-padding = 2;
        
        cursor-click = "pointer";
        cursor-scroll = "ns-resize";
      };
      
      "module/i3" = {
        type = "internal/i3";
        pin-workspaces = true;
        show-urgent = true;
        strip-wsnumbers = true;
        index-sort = true;
        enable-click = true;
        enable-scroll = false;
        wrapping-scroll = false;
        reverse-scroll = false;
        fuzzy-match = true;
        
        ws-icon-0 = "1;♚";
        ws-icon-1 = "2;♛";
        ws-icon-2 = "3;♜";
        ws-icon-3 = "4;♝";
        ws-icon-4 = "5;♞";
        ws-icon-default = "♟";
        
        format = "<label-state> <label-mode>";
        
        label-mode = "%mode%";
        label-mode-padding = 2;
        label-mode-foreground = "#e0af68";
        
        label-focused = "%index%";
        label-focused-foreground = "#7aa2f7";
        label-focused-background = "#24283b";
        label-focused-underline = "#7aa2f7";
        label-focused-padding = 2;
        
        label-unfocused = "%index%";
        label-unfocused-padding = 2;
        
        label-visible = "%index%";
        label-visible-underline = "#414868";
        label-visible-padding = 2;
        
        label-urgent = "%index%";
        label-urgent-foreground = "#f7768e";
        label-urgent-padding = 2;
      };
      
      "module/date" = {
        type = "internal/date";
        interval = 5;
        
        date = "";
        date-alt = " %Y-%m-%d";
        
        time = "%H:%M";
        time-alt = "%H:%M:%S";
        
        format-prefix = "󰥔 ";
        format-prefix-foreground = "#7aa2f7";
        
        label = "%date% %time%";
      };
      
      "module/filesystem" = {
        type = "internal/fs";
        interval = 25;
        
        mount-0 = "/";
        
        format-mounted-prefix = " ";
        format-mounted-prefix-foreground = "#9ece6a";
        format-mounted = "<label-mounted>";
        label-mounted = "%percentage_used%%";
      };
      
      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        format-prefix = "󰍛 ";
        format-prefix-foreground = "#e0af68";
        label = "%percentage_used%%";
      };
      
      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format-prefix = "󰻠 ";
        format-prefix-foreground = "#f7768e";
        label = "%percentage:2%%";
      };
      
      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        
        format-volume = "<ramp-volume> <label-volume>";
        label-volume = "%percentage%%";
        
        label-muted = "󰝟 muted";
        label-muted-foreground = "#737aa2";
        
        ramp-volume-0 = "󰕿";
        ramp-volume-1 = "󰖀";
        ramp-volume-2 = "󰕾";
        ramp-volume-foreground = "#4abaaf";
        
        click-right = "pavucontrol";
      };
      
      "module/wlan" = {
        type = "internal/network";
        interface = "wlp2s0";
        interval = "3.0";
        
        format-connected = "<ramp-signal> <label-connected>";
        label-connected = "%essid%";
        
        ramp-signal-0 = "󰤯";
        ramp-signal-1 = "󰤟";
        ramp-signal-2 = "󰤢";
        ramp-signal-3 = "󰤥";
        ramp-signal-4 = "󰤨";
        ramp-signal-foreground = "#9a7ecc";
      };
      
      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";  # You might need to change this to match your battery
        adapter = "ADP1";  # You might need to change this to match your power adapter
        full-at = 98;
        
        format-charging = "<animation-charging> <label-charging>";
        
        format-discharging = "<ramp-capacity> <label-discharging>";
        
        format-full-prefix = " ";
        format-full-prefix-foreground = "#9ece6a";
        
        ramp-capacity-0 = "";
        ramp-capacity-1 = "";
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";
        ramp-capacity-foreground = "#9ece6a";
        
        animation-charging-0 = "";
        animation-charging-1 = "";
        animation-charging-2 = "";
        animation-charging-3 = "";
        animation-charging-4 = "";
        animation-charging-foreground = "#9ece6a";
        animation-charging-framerate = 750;
      };
    };
  };

  home.stateVersion = "24.05";
  # Let home-manager install and manage itself.
  programs.home-manager.enable = true;
}
