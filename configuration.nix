{
  modulesPath,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  services.openssh.enable = true;

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPwZL27kGTQDIlSe03abT9F24nSAizORyjo5cI3BD92s your_email@example.com"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOJ6+aLTPanIYS88EjCVtCZv6pw2jC4lIIZNRY6VrnoF pungkula@laptop"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICLU9Ri6EVsKMHMXm1L5N0sU9qUVrQDgmC+o6vJnik9u pungis@nasty"
  ];

  system.stateVersion = "24.05";
}
