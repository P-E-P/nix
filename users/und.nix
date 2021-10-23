{ pkgs, ... }:

{
  isNormalUser = true;
  home = "/home/und";
  description = "Und";
  shell = pkgs.bash;
  uid = 4242;
  extraGroups = [ "wheel" "networkmanager" "audio" "libvirtd" "docker"];

  packages = with pkgs; [
    htop binutils
    gnupg
    neofetch
  ];
}
