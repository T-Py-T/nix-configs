{ config, pkgs, specialArgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/_all_systems.nix
    ../../modules/tmux.nix
    ../../modules/zsh.nix
    ../../modules/nvim.nix
    ../../modules/alacritty.nix
    ../../modules/btop.nix
    ../../modules/i3.nix
    ../../modules/rofi.nix
    ../../modules/git.nix
    ../../modules/fastfetch.nix
    ../../modules/nemo.nix
    ../../modules/remmina.nix
    # ../../modules/virtualbox.nix
  ];

  # Home Manager configurations
  home-manager.users.root.home.stateVersion = "24.05";
  home-manager.users.${specialArgs.primary-user} = {
    home.stateVersion = "24.05";
  };

  # Services and System Configuration
  services.ratbagd.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  hardware.ckb-next.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  services.gnome.gnome-keyring.enable = true;

  services.openssh.enable = true;
  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';
  virtualisation.docker.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  # Bootloader configuration
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  # Networking and Host Information
  networking.hostName = "desktop";
  networking.networkmanager.enable = true;

  # User and Group Configuration
  users.users.${specialArgs.primary-user} = {
    isNormalUser = true;
    description = specialArgs.primary-user;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    hashedPasswordFile = config.sops.secrets.passwd.path;
    packages = with pkgs; [
      gtk3
      sshfs
      piper
      vscode
      openvpn
      meld
      curl
      xarchiver
      pavucontrol
      vlc
      wget
      eza
      lazygit
      steam
      brave
      feh
      killall
      stdenv
      dunst
      copyq
      xsel
      xautolock
      fnm
      maim
      discord 
      docker-compose
      dbeaver-bin
      rustup
      libreoffice
    ];
  };

  # System State Version
  system.stateVersion = "24.05";
}
