{ pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1"; # Needed by mpd to be able to use Pulseaudio
  };

  services = {
    printing.enable = true;

    xserver = {
      enable = true;

      layout = "fr";
      xkbOptions = "eurosign:e";

      libinput.enable = true;

      displayManager.lightdm.enable = true;
    };

    geoclue2.enable = true;
  };

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


  environment.systemPackages = with pkgs; [ firefox ];

}
