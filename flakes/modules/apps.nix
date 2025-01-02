{ config, lib, pkgs, ... }:

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
      cbonsai
      snowmachine
      sl
      cowsay
      fastfetch

      vim
      kitty
      warp-terminal
      tree
      htop
      clinfo
      grub2

      brave
      firefox
      google-chrome

      kate
      git
      direnv
      remmina
      cloudflare-warp
      duplicati
      vscode
      # jetbrains.idea-community
      postman

      canon-cups-ufr2

      ibus-engines.bamboo
      ibus-engines.libpinyin

      solaar
      logitech-udev-rules
      firewalld-gui
      systemd
      ddcutil
      fan2go
      lm_sensors

      qemu
      # quickemu
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
      powerdevil
      knotifications
      knotifyconfig
    ]);
  };
}
