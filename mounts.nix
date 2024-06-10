{ config, pkgs, ... }:

{
	fileSystems."/mnt/nas-share-luka" = {
		device = "10.0.0.5:/volume1/nas-share-luka";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" ];
	};	
	fileSystems."/mnt/public-share" = {
		device = "10.0.0.5:/volume1/public-share";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" ];
	};
	fileSystems."/mnt/proxmox-backup" = {
		device = "10.0.0.5:/volume1/proxmox-backup";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" ];
	};



}
