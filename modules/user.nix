{ lib, config, pkgs, ... }:

let
  cfg = config.user;
in
{
  options.user = {
    enable = lib.mkEnableOption "Enable user module";
    name = lib.mkOption {
      default = "user";
      description = "Create a user by given username, user is default.";
    };
    hashedPassword = lib.mkOption {
      default = "$y$j9T$GPVHUT6vyRKV3CLRQ7Vs70$9FaKkTuLSLSN7vvSZuaSztPDt9M8zdRVAMZmnieTm.7";
      description = "Create a user by given username, password is default.";
    };
    extraGroups = lib.mkOption {
      default = [ "wheel" ];
      description = "Groups given to user, defaults are [ \"wheel\" ].";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.name} = {
      isNormalUser = true;
      hashedPassword = cfg.hashedPassword;
      description = cfg.name;
      extraGroups = cfg.extraGroups;
    };
  };
}
