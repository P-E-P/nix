{ pkgs, ... }:

{
  isNormalUser = true;
  home = "/home/und";
  description = "Und";
  shell = pkgs.bash;
  uid = 4242;
  extraGroups = [ "wheel" "networkmanager" "audio" "libvirtd" "docker"];

  packages = with pkgs; [
    # Utils
    zip unzip lz4 unrar
    alacritty htop binutils
    gnupg

    # Dev
    rustup cargo
    gcc m4 gnumake
    clang ctags radare2 valgrind clang-tools
    cmake patchelf

    # Virt
    docker-compose virt-viewer virt-manager win-virtio

    # Misc
    firefox pavucontrol ncmpcpp imagemagick
    neofetch feh
    # Fonts
    dejavu_fonts
  ];
}
