{ lib, pkgs, specialArgs, ... }:

let usernames = [  specialArgs.primary-user ];
in {
  home-manager.users = lib.attrsets.genAttrs usernames (username: ({
    programs.tmux = {
      baseIndex = 1;
      clock24 = true;
      enable = true;
      escapeTime = 0;
      extraConfig = "
        unbind %
        unbind '\"'
        bind c new-window -c '#{pane_current_path}'
        bind e send-prefix
        bind h split-window -v
        bind v split-window -h
        bind r source-file ~/.tmux.conf
        bind-key C-a last-window
        bind-key C-c new-window -c '#{pane_current_path}'
        bind-key C-d detach-client
        bind-key C-s detach-client
        bind-key -n F1  select-window -t 1
        bind-key -n F2  select-window -t 2
        bind-key -n F3  select-window -t 3
        bind-key -n F4  select-window -t 4
        bind-key -n F5  select-window -t 5
        bind-key -n F6  select-window -t 6
        bind-key -n F7  select-window -t 7
        bind-key -n F8  select-window -t 8
        bind-key -n F9  select-window -t 9
        bind-key -n F10 select-window -t 10
        bind-key -n F11 previous-window
        bind-key -n F12 next-window
        set -g status-justify centre
        set -g status-left '#[fg=#ffa000]#H#[default]'
        set -g status-right-style fg=#808080 # Default text color
        set -g status-right '#[fg=#00d7ff]%H:%M #[fg=#005fff]%d %b#[default]'
        set -ga terminal-overrides ',xterm-256color:Tc'
        set -ga terminal-overrides ',screen-256color:Tc'
        set -ga terminal-overrides ',xterm-termite:Tc'
        setw -g alternate-screen on
        setw -g window-status-style fg=#ffffff
        setw -g window-status-current-format '#[fg=#af00ff]#I#F#W#[default]'
        set-option -g status-style bg=default # Transparent background
      ";
      historyLimit = 30000;
      mouse = false;
      newSession = false;
      prefix = "C-a";
      terminal = "screen-256color";
    };
  }));
}
