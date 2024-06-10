{ pkgs, config, lib, ... }:
{
	virtualisation.docker = {
		enable = true;
		rootless.enable = true;
		rootless.setSocketVariable = true;
	};
}
