# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./vim.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Omega"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };


  # Enable X11
  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  # Configure keymap in X11
  services.xserver.layout = "fr";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # List services that you want to enable:
  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1"; # Needed by mpd to be able to use Pulseaudio
  };

  # Music daemon, can be accessed through mpc or an other client
  services.mpd = {
    enable = true;
    extraConfig = ''
      input {
        plugin "curl"
      }
      audio_output {
        type "pulse" # MPD must use Pulseaudio
        name "Pulseaudio" # Whatever you want
        server "127.0.0.1"
      }
      audio_output {
        type "fifo"
        name "mpd_fifo"
        path "/tmp/mpd.fifo"
        format "44100:16:2"
      }
    '';
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;


  environment.variables = { 
    EDITOR = "vim";
    PAGER = "most";
  };

  users.users.und = {
    isNormalUser = true;
    home = "/home/und";
    description = "Und";
    shell = pkgs.bash;
    uid = 4242;
    extraGroups = [ "wheel" "networkmanager" "audio"];

    packages = with pkgs; [
      htop neofetch zip unzip feh lz4 patchelf unrar gnupg imagemagick alacritty rofi
      rustup gcc m4 gnumake binutils docker-compose dejavu_fonts vlc obs-studio cargo
      clang ncmpcpp ctags include-what-you-use
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim
    firefox
    pciutils
    git
    pavucontrol
    feh
    file
    most
  ];


  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Hack" ]; })
    ];

    fontconfig = {
      hinting.enable = true;
      defaultFonts = {
        serif = [ "FiraCodeNerdFontComplete-Regular" ];
        sansSerif = [ "FiraCodeNerdFontComplete-Regular" ];
        monospace = [ "FiraCodeNerdFontCompleteM-Regular" ];
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}
