{ config, pkgs, ibus-pkgs, ... }:

{
  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];

      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };

      # Enable the KDE Plasma Desktop Environment.
      desktopManager.plasma5.enable = false;
    };

    displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;
    };

    desktopManager.plasma6.enable = true;
  };

  # Vietnamese typing setup
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      addons = with pkgs; [ fcitx5-bamboo ];
    };
    # ibus.engines = with ibus-pkgs.ibus-engines; [ bamboo libpinyin ];
  };

  environment.systemPackages = with pkgs.kdePackages; [
    kmines
    kmahjongg
    kpat
    kcalendarcore
    kamera
    networkmanager-qt
    plasma-pa
    plasma-firewall
    powerdevil
    knotifications
    knotifyconfig
    wrapQtAppsHook
    # fcitx5-with-addons
  ];
}
