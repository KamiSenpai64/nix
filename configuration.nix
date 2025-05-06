# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enable flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager.enable = true;
  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  # Set your time zone.
  time.timeZone = "Europe/Bucharest"; # Change to your timezone

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";

    # Enable the Ly display manager
    displayManager = {
      ly = {
        enable = true;
      };
    };

    # Enable i3wm window manager
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
      ];
    };
  };

  # Enable sound with pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # User account
  users.users.daniel = {  # Change to your username
    isNormalUser = true;
    description = "NixOS User";  # Change to your description
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.zsh;
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Enable ZSH
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    # Essentials
    wget
    curl
    git
    vim
    neovim
    htop
    yazi  # File manager
    kitty  # Terminal
    firefox
    
    # Development tools
    gnumake
    gcc
    lazygit
    
    # Gaming
    prismlauncher  # Minecraft launcher
    jdk17  # Java for Minecraft
    
    # i3wm utilities
    rofi  # Application launcher
    feh  # Image viewer and wallpaper setter
    nitrogen  # Wallpaper manager
    picom  # Compositor
    arandr  # Monitor layout
    lxappearance  # Theme configuration
    xfce.thunar  # File manager
    
    # System utilities
    unzip
    zip
    flameshot  # Screenshot tool
    pavucontrol  # Audio control
    brightnessctl  # Brightness control
    
    # Fonts
    font-awesome
    nerdfonts
  ];

  # Set default editor to neovim
  environment.variables.EDITOR = "nvim";

  # Enable fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    font-awesome
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
  ];

  # Enable the OpenSSH daemon
  services.openssh.enable = true;

  # System state version
  system.stateVersion = "23.11"; # Don't change this!
}
