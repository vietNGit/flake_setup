{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "vietmacbook";
  home.homeDirectory = "/Users/vietmacbook";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.05";

  programs = {
    ghostty = {
      enable = true;

      # 1. Tell Home Manager NOT to install the ghostty package from nixpkgs
      package = null;

      settings = {
        theme = "Catppuccin Frappe";
        font-size = 15;
        font-family = "MesloLGM Nerd Font Mono";
      };
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "ys";
        plugins = [
          "git"
          "direnv"
        ];
      };
    };
  };
}
