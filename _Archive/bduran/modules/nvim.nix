{ pkgs, specialArgs, ... }:

{
  home-manager.users.${specialArgs.primary-user} = { config, ... }: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;

    };


    # Include lua-language-server as a package for the user environment
    home.packages = [
      pkgs.lua-language-server
      pkgs.nil
    ];

    # Define the Neovim configuration file with an out-of-store symlink
    home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/dotfiles/nvim";
  };
}

