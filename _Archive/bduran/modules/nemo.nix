{ pkgs, config, specialArgs, ... }:

{
  # Install Nemo and desired extensions in system packages
  environment.systemPackages = with pkgs; [
    cinnamon.nemo                    # Nemo file manager
    cinnamon.nemo-fileroller         # Archive manager extension for Nemo
    cinnamon.nemo-python             # Python extension support for Nemo
  ];

  # Configure Nemo settings using dconf
  environment.etc."dconf/user".source = pkgs.writeText "nemo-dconf-settings" ''
    [org/nemo/preferences]
    show-hidden-files=true
    confirm-trash=true
    click-policy='double'
    default-folder-viewer='list-view'
    sort-directories-first=true
    show-reload=true
    start-with-sidebar=true
    start-with-location-bar=false
  '';
}
