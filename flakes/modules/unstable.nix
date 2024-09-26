{ config, lib, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    firefox
    google-chrome

    fastfetch
    vscode
    jetbrains.idea-community
    postman

    appflowy
    affine
    libreoffice-fresh
  ];
}