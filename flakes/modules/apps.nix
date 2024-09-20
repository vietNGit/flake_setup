{ config, pkgs, pkgs-unstable, ... }:

{
  services = {
    flatpak.enable = true;
    udev = {
      enable = true;
      packages = with pkgs; [
        logitech-udev-rules
      ];
    };
    ratbagd.enable = true;
  };

  environment.systemPackages = (with pkgs; [
    vim
    tree
    htop
    cbonsai
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

    piper
    libratbag
    solaar
    logitech-udev-rules
    busybox
    fwupd

    qemu
    quickemu
    virt-manager
    virtualbox
  ])
  ++ (with pkgs-unstable;[
    firefox
    google-chrome

    vscode
    jetbrains.idea-community
    postman

    appflowy
    affine
    libreoffice-fresh
  ]);
}
