{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ../configuration.nix
    inputs.nixos-hardware.nixosModules.dell-xps-17-9700-intel
  ];

  modules.base.enable = true;
  modules.desktop.enable = true;
  modules.xmonad.enable = true;
  modules.extra.enable = false;
  modules.code.enable = true;
  modules.games.enable = false;
  modules.syncthing.enable = true;
  modules.fonts.enable = true;
  modules.nixified-ai.enable = false;

  hardware.enableRedistributableFirmware = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];

  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.xserver.libinput.enable = true;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/bfe4586b-2538-4aae-ad2f-b1277378de4a";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5C09-F06F";
      fsType = "vfat";
    };

  swapDevices = [ ];

  networking.hostName = "adele";

  nix.settings.maxJobs = lib.mkDefault 12;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  system.stateVersion = "20.03";
}
