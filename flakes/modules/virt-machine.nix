{ config, pkgs, pkgs-stable ? pkgs-stable : null, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_full;
    };
    # virtualbox = {
    #   host = {
    #     enable = true;
    #     enableExtensionPack = true;
    #   };
    #   guest.enable = true;
    # };
    qemu.package = pkgs.qemu_full;
  };

  services.qemuGuest.enable = true;

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    quickemu
    distrobox
  ];
}
