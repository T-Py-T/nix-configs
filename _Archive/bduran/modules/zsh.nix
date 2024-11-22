
{ lib, pkgs, specialArgs, ... }:

let
  ohMyZshPath = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
in
{
  home-manager.users.${specialArgs.primary-user} = { config, ... }: {
    programs.zsh = {
      enable = true;
      initExtra = ''
        export ZSH="${ohMyZshPath}"
        ZSH_THEME="xiong-chiamiov"
      '';
    };

    # Define the home file configuration with an out-of-store symlink for .zshrc
    home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/dotfiles/zsh/.zshrc";

    # Install Oh My Zsh and plugins
    home.packages = with pkgs; [
      oh-my-zsh
      zsh-syntax-highlighting
      zsh-autosuggestions
      zsh-history-substring-search
    ];
  };

  # Set Zsh as the default shell for the primary user
  users.defaultUserShell = pkgs.zsh;
}

