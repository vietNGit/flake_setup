{ config, pkgs, ... }:

{
  virtualisation = {
    libvirtd.enable = true;
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
      guest.enable = true;
    };
  };

  programs.virt-manager.enable = true;
}
