{ pkgs, lib, config, ... }:

{
  imports = [ ../desktop.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };


  networking = {

    hostName = "Omega"; # Define your hostname.

    networkmanager.enable = true;
    interfaces.enp2s0.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;

    firewall = {
      allowedUDPPorts = [ 51820 ];
    };

    wireguard.interfaces = {
      lse0 = {
        ips = [ "192.168.105.19/32" ];
        listenPort = 51820;

        privateKeyFile = "/home/und/.config/wireguard/privatekey";
        peers = [
          # For a client configuration, one peer entry for the server will suffice.
          {
            # Public key of the server (not a file path).
            publicKey = "{t+e8zq+rVZD+ObsbdXSRByyG9XyfC+fSPqY2PTAyYz4=}";
            # Forward all the traffic via VPN.
            allowedIPs = [ "192.168.100.0/24" "192.168.102.0/23" "192.168.104.0/24" "10.224.4.0/24" "192.168.110.0/24" ];
            # Or forward only particular subnets
            # Set this to the server IP and port.
            endpoint = "{91.243.117.249}:51820";

          }
        ];
      };
    };
  };


  virtualisation = {
    docker.enable = true;

    libvirtd = {
      enable = true;
      onBoot = "ignore";
      qemuPackage = pkgs.qemu_kvm;
    };
  };

  # Enable X11
  services = {
    xserver.windowManager.i3.enable = true;

    # Music daemon, can be accessed through mpc or an other client
    mpd = import ./omega/mpd.nix {};
  };

}
