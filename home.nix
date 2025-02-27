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
        opacity = 0.50;
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
        border = 2;
        titlebar = false;
      };

      gaps = {
        inner = 5;
        outer = 5;
      };

      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+b" = "exec ${pkgs.brave}/bin/brave";
        "${modifier}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";
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

  
  home.stateVersion = "24.05";
  # Let home-manager install and manage itself.
  programs.home-manager.enable = true;
}
