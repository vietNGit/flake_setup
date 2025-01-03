{ config, pkgs, pkgs-stable, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      # qemu.package = pkgs.qemu_full;
    };
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
      guest.enable = true;
    };
    # qemu.package = pkgs.qemu_full;
  };

  services.qemuGuest.enable = true;

  programs.virt-manager.enable = true;
}
