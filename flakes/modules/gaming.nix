{ config, pkgs, pkgs-stable, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    package = pkgs-stable;
  };
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
  ];
}
