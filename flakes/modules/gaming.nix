{ config, pkgs, pkgs-stable, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    package = pkgs-stable.steam;
  };
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
  ];
}
