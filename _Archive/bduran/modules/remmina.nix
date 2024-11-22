{ pkgs, specialArgs, ... }:

{
  home-manager.users.${specialArgs.primary-user} = {
    home.packages = with pkgs; [
      remmina                   # Main Remmina application with all built-in plugins
    ];

    # Configure Remmina preferences
    xdg.configFile."remmina/remmina.pref".text = ''
      [remmina_pref]
      hide_toolbar_on_fullscreen=false
      save_view_mode_per_protocol=true

      # Default resolution
      view_mode=3                      # Set view mode (3 is "scaling")
      screen_width=1920
      screen_height=1080

      # Clipboard
      share_clipboard=true
    '';
  };
}
