{ lib, config, impermanence, ... }:

let
  cfg = config.preferences;
in
{
  imports = [ impermanence.nixosModules.impermanence ];

  options.preferences = {
    impermanence = lib.mkEnableOption "Defines if target will use Impermanence";
  };

  config = lib.mkIf cfg.impermanence {
    environment.persistence."/nix/persist/system" = {
      hideMounts = true;
      directories = [
        "/home/${config.user.name}"
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ];
      files = [
        "/etc/machine-id"
      ];
    };
  };
}
