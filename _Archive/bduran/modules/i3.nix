{ lib, pkgs, specialArgs, ... }:

{
  # Home Manager configuration for the user, specifically for i3-related configurations
  home-manager.users.${specialArgs.primary-user} = { config, ... }: {
    # Enable i3-related configurations for the user
    home.file = {
      ".config/i3".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/dotfiles/i3";
      ".config/i3blocks".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/dotfiles/i3blocks";
    };
  };

  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3status
        i3lock
        i3blocks
      ];
    };
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager = {
    enable = true;
    defaultSession = "none+i3";
  };
}

