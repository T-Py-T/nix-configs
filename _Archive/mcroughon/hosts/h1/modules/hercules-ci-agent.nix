{ config, ... }:
{
  services.hercules-ci-agents."taylor-swordfish" = {
    settings = {
      clusterJoinTokenPath = config.age.secrets.taylorHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.taylorHerculesBinaryCaches.path;
    };
  };

  services.hercules-ci-agents."stardustxr-swordfish" = {
    settings = {
      clusterJoinTokenPath = config.age.secrets.stardustXrHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.stardustXrHerculesBinaryCaches.path;
      secretsJsonPath = config.age.secrets.stardustXrHerculesSecrets.path;
    };
  };

  age.secrets = {
    taylorHerculesClusterJoinToken = {
      file = ../../../secrets/taylorHerculesClusterJoinToken.age;
      group = "hci-taylor-swordfish";
      owner = "hci-taylor-swordfish";
    };
    taylorHerculesBinaryCaches = {
      file = ../../../secrets/taylorHerculesBinaryCaches.age;
      group = "hci-taylor-swordfish";
      owner = "hci-taylor-swordfish";
    };
    stardustXrHerculesClusterJoinToken = {
      file = ../../../secrets/stardustXrHerculesClusterJoinToken.age;
      group = "hci-stardustxr-swordfish";
      owner = "hci-stardustxr-swordfish";
    };
    stardustXrHerculesBinaryCaches = {
      file = ../../../secrets/stardustXrHerculesBinaryCaches.age;
      group = "hci-stardustxr-swordfish";
      owner = "hci-stardustxr-swordfish";
    };
    stardustXrHerculesSecrets = {
      file = ../../../secrets/stardustXrHerculesSecrets.age;
      group = "hci-stardustxr-swordfish";
      owner = "hci-stardustxr-swordfish";
    };
  };
}
