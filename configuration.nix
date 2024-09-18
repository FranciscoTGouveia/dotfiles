{ config, pkgs, ... }:

{

  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
    hostName = "poseidon";
    networkmanager.enable = true;
  };

  # edit as per your location and timezone
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
      LC_CTYPE="en_US.utf8"; # required by dmenu don't change this
    };
  };

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
 

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver = {
    enable = true;
    layout = "pt";
    xkbVariant = "";
    displayManager.defaultSession = "none+i3";
    windowManager.i3 = { enable = true; };
  };

  console.keyMap = "pt-latin1";

  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
  };


  users.users.francisco = {
    isNormalUser = true;
    description = "francisco";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # web
      firefox
      brave
      
      # media
      discord
      spotify
      
      # dev
      vscode
      neovim
      lazygit
      go
      gcc
      gnumake
      clang
      git
      llvm_18

      # tools
      tldr
      tmux
      ripgrep

      # cybersec
      traceroute
      openvpn
      nmap
      wireshark

      # graphical
      alacritty
      dmenu
      networkmanagerapplet
      
      # Need to add Stenography Tools
      # Need to add Stenography Tools
      # Need to add Stenography Tools
    ];
  };

  environment.systemPackages = with pkgs; [
    # Core
    vim
    wget
    curl
    
    # nix
    nixfmt
    nixpkgs-fmt
    home-manager
   
    # dev
    python3
    dconf
    nodejs
  ];

  programs = {
    thunar.enable = true;
    dconf.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Don't touch this
  system.stateVersion = "24.05";
}
