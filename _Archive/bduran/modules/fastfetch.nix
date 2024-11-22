{ lib, pkgs, specialArgs, ... }:

{
  # Define options for enabling fastfetch
  options.programs.fastfetch = {
    enable = lib.mkBoolOption "Enable Fastfetch for system information display";
  };

  # Move home-manager configuration into the `config` attribute
  config = {
    home-manager.users.${specialArgs.primary-user} = { config, ... }: {
      programs.fastfetch = {
        enable = true;
        settings = {
          "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
          logo = {
            padding = {
              top = 2;
            };
          };
          display = {
            color = {
              keys = "green";
              title = "blue";
            };
            percent = {
              type = 9;
            };
            separator = " → ";
          };
          modules = [
            {
              type = "custom";
              outputColor = "blue";
              format = ''┌──────────── OS Information ────────────┐'';
            }
            {
              type = "title";
              key = " ";
              keyColor = "green";
              color = {
                user = "green";
                host = "green";
              };
            }
            {
              type = "os";
              key = " ";
              keyColor = "green";
            }
            {
              type = "kernel";
              key = " ";
              keyColor = "green";
            }
            {
              type = "packages";
              key = " ";
              keyColor = "green";
            }
            {
              type = "shell";
              key = " ";
              keyColor = "green";
            }
            # DE Information Section
            {
              type = "custom";
              outputColor = "blue";
              format = ''├──────────── DE Information ────────────┤'';
            }
            {
              type = "de";
              key = "  DE";
              keyColor = "blue";
            }
            {
              type = "wm";
              key = "  WM";
              keyColor = "blue";
            }
            {
              type = "lm";
              key = " 󰧨 Login Manager";
              keyColor = "blue";
            }
            {
              type = "wmtheme";
              key = " 󰉼 WM Theme";
              keyColor = "blue";
            }
            {
              type = "icons";
              key = " 󰀻 Icons";
              keyColor = "blue";
            }
            # Hardware Information Section
            {
              type = "custom";
              outputColor = "blue";
              format = ''├───────── Hardware Information ─────────┤'';
            }
            {
              type = "display";
              key = " 󰍹 Display";
              keyColor = "blue";
              compactType = "original-with-refresh-rate";
            }
            {
              type = "cpu";
              key = " 󰍛 CPU";
              keyColor = "blue";
            }
            {
              type = "gpu";
              key = "  GPU";
              keyColor = "blue";
            }
            {
              type = "disk";
              key = " 󱛟 Disk";
              keyColor = "blue";
            }
            {
              type = "memory";
              key = "  Memory";
              keyColor = "blue";
            }
            {
              type = "custom";
              outputColor = "blue";
              format = ''└────────────────────────────────────────┘'';
            }
          ];
        };
      };
    };
  };
}
