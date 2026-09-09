{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    qemu_full
    utm
  ];
}
