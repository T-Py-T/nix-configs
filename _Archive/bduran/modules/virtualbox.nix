{ specialArgs, ... }:

{
  users.extraGroups.vboxusers.members = [ specialArgs.primary-user ];
  virtualisation = {
    virtualbox = {
      guest.enable = true;
      guest.draganddrop = true;
      host.enable = true;
      host.enableExtensionPack = true;
    };
  };
}
