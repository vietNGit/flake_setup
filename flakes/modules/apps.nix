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

    environment.systemPackages = (with pkgs; [
      vim
      kitty
      warp-terminal
      tree
      htop
      cbonsai
      sl
      cowsay
      clinfo
      fastfetch

      brave
      firefox
      google-chrome

      kate
      git
      direnv
      remmina
      cloudflare-warp
      duplicati
      docker
      docker-compose
      vscode
      jetbrains.idea-community
      postman

      canon-cups-ufr2

      ibus-engines.bamboo
      ibus-engines.libpinyin

      solaar
      logitech-udev-rules
      firewalld-gui
      systemd

      qemu
      quickemu
      virt-manager
      virtualbox

      zoom-us
      vlc
      appflowy
      affine
      libreoffice
      wpsoffice
    ]) ++ (with pkgs.libsForQt5; [
      kmines
      kmahjongg
      kpat
      kcalendarcore
      kamoso
      networkmanager-qt
      plasma-pa
      plasma-firewall
    ]);
  };
}
