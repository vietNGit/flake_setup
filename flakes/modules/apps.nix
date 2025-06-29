{ config, lib, pkgs, pkgs-stable ? pkgs-stable : null, ... }:

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

      # Bios update service
      fwupd.enable = true;
    };

    systemd.packages = [ pkgs.cloudflare-warp ]; # for warp-cli
    systemd.targets.multi-user.wants = [ "warp-svc.service" ];

    environment.systemPackages = (with pkgs; [
      cbonsai
      snowmachine
      sl
      cowsay
      fastfetch

      kitty
      warp-terminal
      ghostty

      vim
      tree
      htop
      clinfo
      grub2
      bat
      efibootmgr
      btop

      vesktop
      bitwarden-desktop

      git
      github-desktop
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
      easyeffects

      zoom-us
      vlc
      appflowy
      affine
      libreoffice
      wpsoffice
      onlyoffice-desktopeditors

      dnf5
      dnf-plugins-core
    ]) ++ (with pkgs-stable; [
      # qemu_full
      # quickemu
    ]);
  };
}
