{ config, pkgs, pkgs-stable ? pkgs-stable : null, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
  ];
}
