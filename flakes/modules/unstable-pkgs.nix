{ config, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable[
    vscode
    appflowy
    affine
  ];
}
