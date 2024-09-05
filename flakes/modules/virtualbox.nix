{ config, pkgs, ... }:

{
  virtualisation = {
    virtualbox = {
      host = {
        enable = true;
        package = pkgs.virtualbox;
        enableExtensionPack = true;
        enableKvm = true;
      };
      guest.enable = true;
    };
  };
}
