# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      # devices = [ "nodev" ];
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      memtest86.enable = true;
      extraEntries = "
        # UEFI boot entry
        menuentry 'UEFI Firmware Settings' $menuentry_id_option 'uefi-firmware' {
          fwsetup
        }
      ";
    };
  };


  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.initrd.luks.devices."luks-4e5e766f-b847-4c92-9c88-6652ae119d7b".device = "/dev/disk/by-uuid/4e5e766f-b847-4c92-9c88-6652ae119d7b";
  networking.hostName = "nixosLaptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # OpenGL setup
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs;[
      amdvlk
    ];
  };

  hardware.amdgpu = {
    opencl.enable = true;
    amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };

  # Setting system power controls
  services.power-profiles-daemon.enable = true;

  services.tlp = {
    enable = false;
    settings = {
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "balanced";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      # START_CHARGE_THRESH_BAT0 = 1;
      STOP_CHARGE_THRESH_BAT0 = 1;
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking = {
    # wireless = {
    #   enable = false;
    #   userControlled.enable = true;
    # };
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openconnect
      ];
    };
  };

  # Set your time zone.
  services = {
    automatic-timezoned = {
      enable = true;
      package = pkgs.automatic-timezoned;
    };
  };
  services.localtimed.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [ canon-cups-ufr2 ];
  };
  services.system-config-printer.enable = true;
  hardware.sane.enable = true;

  # Enable bluetooth on startup
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };

  # Enable sound with pipewire.
  # hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.viet = {
    isNormalUser = true;
    description = "viet";
    extraGroups = [
      "networkmanager" "wheel" "vboxusers" "libvirtd" "podman" "scanner" "lp"
    ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  programs.partition-manager.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 20d";
  };
}
