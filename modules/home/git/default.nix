{ ... }: {
  programs.git = {
    enable = true;

    userName = "T-Py-T";
    userEmail = "tnt850910@aol.com";

    # # Sign commits by default.
    # # Actual key should be provided by GPG module, or signing disabled with `git config --local` per project.
    # signing = {
    #   key = "64A2168E274BF8AF";
    #   signByDefault = true;
    # };

    extraConfig = {
      credential.helper = "cache";
      init.defaultBranch = "main";
    };
  };
}
