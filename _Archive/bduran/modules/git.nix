{ config, lib, pkgs, specialArgs, ... }:

let
  primaryUser = specialArgs.primary-user;
  sshPublicKeyPath = "/run/secrets/github_public_key";
in
{
  # Make these programs accessible to root and other users
  environment.systemPackages = with pkgs; [
    git
    meld # GUI diff tool
  ];

  # Configure Git for the primary user using Home Manager
  home-manager.users.${primaryUser}.programs.git = {
    enable = true;
    userEmail = "benjamind10@pm.me";   # Set your Git email
    userName = "benjamind10";          # Set your Git username

    # Set meld as the default diff and merge tool
    extraConfig = {
      diff.guitool = "meld";
      difftool.prompt = false;
      difftool.meld.cmd = "meld \"$LOCAL\" \"$REMOTE\"";
      merge.tool = "meld";
      mergetool.prompt = false;
      mergetool.meld.cmd = "meld \"$LOCAL\" \"$MERGED\" \"$REMOTE\" --output=\"$MERGED\"";
    };
  };

  # Set up SSH key for Git access
  users.users.${primaryUser}.openssh.authorizedKeys.keys = lib.optional (builtins.pathExists sshPublicKeyPath) [
    (builtins.readFile sshPublicKeyPath)
  ];
}
