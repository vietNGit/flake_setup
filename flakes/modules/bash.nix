{ config, pkgs, ... }:

{
  programs.bash = {
    undistractMe = {
      enable = true;
      playSound = true;
      timeout = 8;
    };
  };

  environment.systemPackages = with pkgs; [
    oh-my-posh
  ];
}
