{ config, pkgs, ... }:

{
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
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
