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
      desktopManager.plasma5.enable = true;
    };

    displayManager = {
      sddm.enable = true;
    };
  };

  environment.systemPackages = with pkgs.libsForQt5; [
    kmines
    kmahjongg
    kpat
    kcalendarcore
    kamoso
    networkmanager-qt
    plasma-pa
    plasma-firewall
    powerdevil
    knotifications
    knotifyconfig
    # fcitx5-with-addons
  ];
}
