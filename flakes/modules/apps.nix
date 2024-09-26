{ config, lib, pkgs, pkgs-unstable, ... }:

{
  config = {
    services = {
      flatpak.enable = true;
      udev = {
        enable = true;
        packages = with pkgs; [
          logitech-udev-rules
        ];
      };
      mullvad-vpn = {
        enable = true;
        package = pkgs-unstable.mullvad;
      };
    };
    environment.systemPackages = with pkgs; [
      vim
      kitty
      tree
      htop
      cbonsai
      sl
      cowsay
      clinfo

      brave

      kate
      git
      direnv
      remmina

      libsForQt5.kmines
      libsForQt5.kmahjongg
      libsForQt5.kpat
      libsForQt5.kcalendarcore
      libsForQt5.kamoso
      libsForQt5.networkmanager-qt

      ibus-engines.bamboo
      ibus-engines.libpinyin

      solaar
      logitech-udev-rules

      qemu
      quickemu
      virt-manager
      virtualbox
    ];
  };
}
