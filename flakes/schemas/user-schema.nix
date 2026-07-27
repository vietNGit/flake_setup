# modules/user-schema.nix
{ lib, ... }:

{
  options.custom.users = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule ({ name, ... }: {
      options = {
        username = lib.mkOption {
          type = lib.types.str;
          default = name;
          description = "Home name of the user profile, will default to login username if not specified";
        };

        hostname = lib.mkOption {
          type = lib.types.str;
          description = "Machine hostname this user profile belongs to";
        };

        gitEmail = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Primary git/contact email for this user profile";
        };
        gitName = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Primary git/contact name for this user profile";
        };
      };
    }));
    default = {};
    description = "Map of user profile names to their system specifications";
  };
}