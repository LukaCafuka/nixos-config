{ pkgs, ... }:
{
	project.name = "gossa-fileserver";
	services.gossafs = {
		service.image = "pldubouilh/gossa";
		service.volumes = [ "/mnt/public-share/algebra:/shared" ];
		service.ports = [ "8001:8001" ];
	};


}
