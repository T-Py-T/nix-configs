{ lib, pkgs, specialArgs, ... }:

let
  usernames = [ specialArgs.primary-user ];
in
{
  home-manager.users = lib.attrsets.genAttrs usernames (username: {
    home.packages = with pkgs; [           
      ueberzugpp
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
      sops
    ];
  });

}
