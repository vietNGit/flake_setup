{ config, lib, pkgs, pkgs-stable, ... }:

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
        package = pkgs.mullvad-vpn;
      };
    };

    systemd.packages = [ pkgs.cloudflare-warp ]; # for warp-cli
    systemd.targets.multi-user.wants = [ "warp-svc.service" ];

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
      cloudflare-warp
      zoom-us
      duplicati
      vlc

      canon-cups-ufr2

      libsForQt5.kmines
      libsForQt5.kmahjongg
      libsForQt5.kpat
      libsForQt5.kcalendarcore
      libsForQt5.kamoso
      libsForQt5.networkmanager-qt
      libsForQt5.plasma-pa

      ibus-engines.bamboo
      ibus-engines.libpinyin

      solaar
      logitech-udev-rules

      qemu
      quickemu
      virt-manager
      virtualbox

      docker
      docker-compose

      firefox
      google-chrome

      fastfetch
      vscode
      jetbrains.idea-community
      postman

      appflowy
      affine
      libreoffice
      wpsoffice
    ];
  };
}
