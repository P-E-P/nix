{ pkgs, ... }:

{
  isNormalUser = true;
  home = "/home/und";
  description = "Und";
  shell = pkgs.bash;
  uid = 4242;
  extraGroups = [ "wheel" "networkmanager" "audio" "libvirtd" "docker"];

  packages = with pkgs; [
    htop neofetch zip unzip feh lz4 patchelf unrar gnupg imagemagick alacritty rofi
    rustup gcc m4 gnumake binutils docker-compose dejavu_fonts cargo
    clang ncmpcpp ctags radare2 valgrind clang-tools win-virtio
    virt-viewer virt-manager cmake firefox pavucontrol
  ];
}
