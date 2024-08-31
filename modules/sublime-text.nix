{ config, lib, pkgs, ... }:

let
  cfg = config.preferences;
in
{
  options.preferences = {
    sublimeText = lib.mkEnableOption "Defines if target wants Sublime Text";
  };
    config = lib.mkIf cfg.sublimeText {

    # sublime requires a EOL version of openssl
    nixpkgs.config.permittedInsecurePackages = [
      "openssl-1.1.1w"
    ];

    environment.systemPackages = with pkgs; [
      sublime4
    ];
  };
}
