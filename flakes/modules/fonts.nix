{ config, pkgs, ... }:

{
  # fonts = {
  #   enableDefaultPackages = true;
  #   packages = with pkgs; [
  #     nerd-fonts.meslo-lg
  #   ];
  # };
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
      };
    };
  };
}
