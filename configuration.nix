{ config, pkgs, ... }:

{

  imports = [
    ./hardware-configuration.nix
  ];


  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # Networking
  networking.hostName = "poseidon";
  networking.networkmanager.enable = true;


  # Time zone
  time.timeZone = "Europe/Lisbon";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_PT.UTF-8";
      LC_IDENTIFICATION = "pt_PT.UTF-8";
      LC_MEASUREMENT = "pt_PT.UTF-8";
      LC_MONETARY = "pt_PT.UTF-8";
      LC_NAME = "pt_PT.UTF-8";
      LC_NUMERIC = "pt_PT.UTF-8";
      LC_PAPER = "pt_PT.UTF-8";
      LC_TELEPHONE = "pt_PT.UTF-8";
      LC_TIME = "pt_PT.UTF-8";
    };
  };
	

  # XServer
  services.xserver = {
    enable = true;
    layout = "pt";
    xkbVariant = "";
    displayManager.defaultSession = "none+i3";
    windowManager.i3 = { enable = true; };
  };

  console.keyMap = "pt-latin1";

  services.printing.enable = true;


  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  users.users.francisco = {
    isNormalUser = true;
    description = "francisco";
    extraGroups = [ "networkmanager" "wheel" "video" "wireshark"];
    packages = with pkgs; [
      # web
      firefox
      brave
      tor-browser
      
      # media
      discord
      spotify
      zoom-us
      
      # dev
      neovim
      lazygit
      go
      gcc
      gdb
      gnumake
      clang
      obsidian
      maven
      jdk22

      # tools
      tldr
      tmux
      ripgrep
      htop
      unzip
      file
      neofetch
      dunst
      nnn
      fzf
      btop
      bat
      pavucontrol
      hexedit
      valgrind

      # cybersec
      traceroute
      openvpn
      nmap

      # graphical
      alacritty
      dmenu
      feh
      i3lock-fancy
      networkmanagerapplet
      flameshot

      # python3
      python312Packages.extras

      # latex
      texlive.combined.scheme-full
    ];
  };

  environment.systemPackages = with pkgs; [
    # Core
    vim
    wget
    curl
    git
    
    # nix
    nixfmt
    nixpkgs-fmt
   
    # dev
    python3
    dconf
    nodejs
  ];

  hardware = {
    bluetooth.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Default editor
  environment.variables = {
    EDITOR = "vim";
    DEV = "/home/francisco/dotfiles/dev-environments/";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  # Install fonts.
  fonts.packages = with pkgs; [ nerdfonts ];

  # Brightness
  programs.light.enable = true;

  # Key bindings
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
    ];
  };

  # Run unpackaged binaries.
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  ];

  # Don't touch this
  system.stateVersion = "24.05";

}
