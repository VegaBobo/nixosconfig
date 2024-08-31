{
  nixpkgs.config.allowUnfree = true;
  services.envfs.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    ./locale.nix
    ../modules
  ];

}
