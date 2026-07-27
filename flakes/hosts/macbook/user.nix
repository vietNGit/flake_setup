# hosts/work-mac/user.nix
{ pkgs, config, ... }:

{
  custom.users.viet = {
    username = "vietmacbook";
  };

  users.users.${config.custom.users.viet.username} = {
    name = config.custom.users.viet.username;
    home = "/Users/${config.custom.users.viet.username}";
    shell = pkgs.zsh;
  };

  system.primaryUser = config.custom.users.viet.username;
}
