{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brave
    google-chrome
    vivaldi
    vivaldi-ffmpeg-codecs

    firefox
    mullvad-browser
    tor-browser
  ];
}
