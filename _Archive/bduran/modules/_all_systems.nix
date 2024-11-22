{ inputs, pkgs, specialArgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 15d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  security.sudo.wheelNeedsPassword = false;

  # Locale settings
  time.timeZone = "America/New_York";
  console.useXkbConfig = true;
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

  # Shell and fonts
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "3270" "DroidSansMono" ]; })
  ];

  programs.traceroute.enable = true; 

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      curl
      glib
      icu
      libdrm
      libusb1
      libuuid
      nspr
      nss
      openssl
      stdenv.cc.cc
      libsecret
      zlib
    ];
  };

  environment.systemPackages = with pkgs; [
    nix-index       # nix-locate nix-channel-index nix-index
    nix-search-cli  # package search
    sops            # sops encryption/decryption
  ];

  home-manager.users.${specialArgs.primary-user}.home.file.".config/sops/age/keys.txt".text = builtins.readFile ../keys.txt;
  home-manager.sharedModules = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = let perms = {
    group = "wheel";
    mode = "0500";
    owner = "${specialArgs.primary-user}";
  }; in {
    age.keyFile = "/home/${specialArgs.primary-user}/.config/sops/age/keys.txt";
    defaultSopsFile = ../secrets.yaml;
    secrets.passwd.neededForUsers = true;
    secrets.github_public_key = perms;
    secrets.github_private_key = perms;
  };

}
