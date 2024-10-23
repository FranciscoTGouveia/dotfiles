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
        size = 8;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };


  # Bash
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      lg = "lazygit";
      nv = "nvim";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      ll = "ls -lh";
      hades = "ssh francisco@85.138.35.238";
    };
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
