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
    # fcitx5-with-addons
  ];
}
