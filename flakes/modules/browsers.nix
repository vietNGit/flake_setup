{ config, pkgs, ibus-pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brave
    google-chrome
    vivaldi
    vivaldi-ffmpeg-codecs
    microsoft-edge

    firefox
    mullvad-browser
    tor-browser
    librewolf
  ];
}
