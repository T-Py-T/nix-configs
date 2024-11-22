{ lib, pkgs, specialArgs, ... }:

let
  usernames = [ specialArgs.primary-user ];
  rangerConfigPath = ../dotfiles/ranger;
in
{
  # Enable Ranger for each user
  home-manager.users = lib.attrsets.genAttrs usernames (username: {
    programs.ranger.enable = true;

    # Only link the files here to avoid conflicts
    home.file = {
      ".config/ranger/rc.conf".source = "${rangerConfigPath}/rc.conf";
      ".config/ranger/rifle.conf".source = "${rangerConfigPath}/rifle.conf";
      ".config/ranger/commands.py".source = "${rangerConfigPath}/commands.py";
      ".config/ranger/colorschemes/gruvbox.py".source = "${rangerConfigPath}/colorschemes/gruvbox.py";
    };
  });
}
