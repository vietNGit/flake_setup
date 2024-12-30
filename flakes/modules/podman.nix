{ config, pkgs, ... }:

{
  virtualisation = {
    containers.enable = true;

    oci-containers.backend = "podman";
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    # docker = {
    #   enable = true;
    #   rootless = {
    #     enable = true;
    #     setSocketVariable = true;
    #   };
    # };
  };

  environment.systemPackages = with pkgs; [
    # docker-compose
    podman-compose
    podman-desktop
  ];
}
