{ config, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    brave
    firefox
    google-chrome

    vscode
    appflowy
    affine
    postman
    libreoffice-fresh
  ];
}
