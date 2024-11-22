# https://github.com/davatorium/rofi
# Launch with winkey + space
{ pkgs, specialArgs, ... }:

{
  home-manager.users.${specialArgs.primary-user}.programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "run,drun,calc";
    };
    plugins = with pkgs; [
      rofi-calc
    ];
    theme = builtins.toFile "rofi-theme.rasi" (builtins.readFile ./gruvbox-dark.rasi);
  };
}
