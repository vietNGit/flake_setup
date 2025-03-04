{ config, pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "MesloLGM Nerd Font" ];
        sansSerif = [ "MesloLGM Nerd Font" ];
        serif = [ "MesloLGM Nerd Font" ];
      };
    };
  };
}
