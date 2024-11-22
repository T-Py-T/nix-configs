{ specialArgs, ... }:

{
  home-manager.users.${specialArgs.primary-user}.programs.alacritty = {
    enable = true;
    settings = {
      cursor = {
        blink_interval = 750;
        style = {
          # Never | Off | On | Always
          blinking = "On";
          # Block | Underline | Beam
          shape = "Block";
        };
        thickness = 0.15;
      };
      font = {
        bold.family = "monospace";
        bold_italic.family = "monospace";
        italic.family = "monospace";
        normal.family = "monospace";
        size = 9;
      };
      mouse = {
        hide_when_typing = true;
      };
      scrolling = {
        # Scrollback buffer
        history = 50000;
        # Number of lines scrolled for every input scroll increment
        multiplier = 3;
      };
      window = {
        # Request compositor to blur content behind transparent windows
        blur = false;
        #decorations = "None";
        dynamic_padding = true;
        opacity = 1;
        startup_mode = "Maximized";
      };

      # Colors (Gruvbox theme)
      colors = {
        primary = {
          background = "#282828";
          foreground = "#ebdbb2";
        };
        cursor = {
          text = "#282828";
          cursor = "#ebdbb2";
        };

        normal = {
          black = "#282828";
          red = "#cc241d";
          green = "#98971a";
          yellow = "#d79921";
          blue = "#458588";
          magenta = "#b16286";
          cyan = "#689d6a";
          white = "#a89984";
        };

        bright = {
          black = "#928374";
          red = "#fb4934";
          green = "#b8bb26";
          yellow = "#fabd2f";
          blue = "#83a598";
          magenta = "#d3869b";
          cyan = "#8ec07c";
          white = "#ebdbb2";
        };
      };
    };
  };
}
