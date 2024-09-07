{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    tree
    htop
    cbonsai

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
  ];
}

