{ config, lib, pkgs, pkgs-unstable, ... }:

{
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

  environment.systemPackages = (with pkgs; [
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
  ])
  ++ (with pkgs-unstable;[
    firefox
    google-chrome

    fastfetch
    vscode
    jetbrains.idea-community
    postman

    appflowy
    affine
    libreoffice-fresh
  ]);
}
