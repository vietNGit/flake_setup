{ config, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    firefox
    google-chrome

    vscode
    appflowy
    affine
    postman
    libreoffice-fresh
  ];
}
