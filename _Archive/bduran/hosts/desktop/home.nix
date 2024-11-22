{ config, pkgs, lib, primary-user, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Install packages for the user, including tmux
  home.packages = with pkgs; [
    alacritty
    tmux               
    ueberzugpp
    neovim
    zsh
    rofi
    ranger
    btop
    home-manager
    sshfs
    vscode
    openvpn
    neofetch
    meld
    curl 
    xarchiver 
    aria 
    pavucontrol 
    vlc 
    wget 
    vim
    eza 
    lazygit
    brave 
    cinnamon.nemo 
    feh 
    killall 
    stdenv 
    dunst 
    copyq 
    xclip
    steam 
    fnm 
    maim 
    discord 
    wget
    sops
  ];

  # Configure dotfiles by linking to the source paths, using relative paths
  home.file.".zshrc".source = ../../dotfiles/.zshrc;
  #home.file.".tmux.conf".source = ../../dotfiles/tmux/.tmux.conf;
  
  home.file.".config/nvim" = {
    source = ../../dotfiles/nvim;
    recursive = true;
  };
  home.file.".config/alacritty" = {
    source = ../../dotfiles/alacritty;
    recursive = true;
  };
  home.file.".config/i3" = {
    source = ../../dotfiles/i3;
    recursive = true;
  };
  home.file.".config/i3blocks" = {
    source = ../../dotfiles/i3blocks;
    recursive = true;
  };
  home.file.".config/rofi" = {
    source = ../../dotfiles/rofi;
    recursive = true;
  };
  home.file.".config/ranger" = {
    source = ../../dotfiles/ranger;
    recursive = true;
  };
  home.file.".config/btop" = {
    source = ../../dotfiles/btop;
    recursive = true;
  };
  home.file.".config/neofetch" = {
    source = ../../dotfiles/neofetch;
    recursive = true;
  };
}
