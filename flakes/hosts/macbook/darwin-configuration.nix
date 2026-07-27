{ self, pkgs, config, ... }:

{
  security.pam.services.sudo_local.touchIdAuth = true;
  system = {
    # Apple specific settings
    defaults = {
      NSGlobalDomain.ApplePressAndHoldEnabled = false;
    };
  };

  nix= {
    gc = {
    # 1. Enable automated garbage collection
    automatic = true;

    # 2. Schedule when it runs using launchd's calendar format
    interval = {
      Weekday = 0; # 0 is Sunday, 1 is Monday, etc.
      Hour = 3;
      Minute = 0;
    };

    # 3. Pass flags to the underlying nix-collect-garbage command
    options = "--delete-older-than 5d";
    };

    settings = {
      # Optional but highly recommended: auto-optimize the store
      # to hard-link duplicate files and save extra space.
      auto-optimise-store = true;

      # Necessary for using flakes on this system.
      experimental-features = "nix-command flakes";
    };
  };

  system = {
    # Set Git commit hash for darwin-version.
    configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 6;
  };
}