{ pkgs, nixfiles, homeManager, nix-colors, ... }: {

  # Nix / System
  system.stateVersion = "24.05";
  time.timeZone = "America/Chicago";
  documentation.nixos.enable = false;
  nix = {
    settings = {
      warn-dirty = false;
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      # substituters = ["https://nix-gaming.cachix.org"];
      # trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    };
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = pkg: builtins.elem (builtins.parseDrvName pkg.name).name ["steam"];
      permittedInsecurePackages = [
          "openssl-1.1.1v"
          "python-2.7.18.7"
      ];
    };
  };



  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Setup home manager.
      homeManager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit nixfiles nix-colors; };
        home-manager.users.taylor = ./home.nix;
      }
      "${nixfiles}/modules/nixos/bootloader"
      "${nixfiles}/modules/nixos/fonts"
      "${nixfiles}/modules/nixos/gpg"
      "${nixfiles}/modules/nixos/homelab"
      "${nixfiles}/modules/nixos/hyprland"
      "${nixfiles}/modules/nixos/locale"
      "${nixfiles}/modules/nixos/network"
      "${nixfiles}/modules/nixos/nix"
      "${nixfiles}/modules/nixos/pipewire"
      "${nixfiles}/modules/nixos/shell"
      "${nixfiles}/modules/nixos/steam"
    ];


  # Install system-wide packages.
  environment.systemPackages = with pkgs; [
    curl
    git
    wget
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.taylor = {
    description = "Taylor";
    isNormalUser = true;

    uid = 1000;
    extraGroups = [
      "audio"
      "docker"
      "disk"
      "flatpak"
      "kvm"
      "libvirtd"
      "networkmanager"
      "qemu"
      "sshd"
      "root"
      "sshd"
      "video"
      "wheel"
    ];
    createHome = true;
    home = "/home/taylor";
    homeMode = "700";

    useDefaultShell = true;
  };


  # Service control
  services = {
    displayManager.autoLogin = {
      enable = true;
      user = "taylor";
    };
    openssh = {
      enable = true;
      openFirewall = true;
    };
  };

  services = {
    flatpak.enable = true;
    dbus.enable = true;
    picom.enable = true;

    xserver = {
      enable = true;
      windowManager.dwm.enable = true;
      layout = "us";

      displayManager = {
        lightdm.enable = true;
        setupCommands = ''
          ${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --off --output DP-2 --off --output DP-3 --off --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal
        '';
        autoLogin = {
          enable = true;
          user = "taylor";
        };
      };
    };
  };

  # Virtualization
  virtualisation.docker.enable = true;

  # Networking Control
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    enableIPv6 = false;
    firewall.enable = false;
  };

}
