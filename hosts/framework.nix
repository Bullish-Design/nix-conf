{ config, ... }:

{
  imports = [
    ../hardware-configuration.nix
  ];

  networking.hostName = "framework";
  networking.enableIPv6 = true;
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  nix.settings.extra-platforms = config.boot.binfmt.emulatedSystems;

  services.fwupd.enable = true;
  services.tailscale.enable = true;
}
