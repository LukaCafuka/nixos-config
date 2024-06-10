{ config, pkgs, ... }:
{
	services.nginx = {
		enable = true;
		virtualHosts = {
			"default" = {
				default = true;
				serverAliases = [ "*.mnogodobar.net" ];
				listen = [
					{ 
						addr = "0.0.0.0"; 
						port = 80;
					} 
					
				];
				locations = {
					"/" = {
						return = "403";
					};
				};
			};
			"mnogodobar.net" = {
				serverName = "mnogodobar.net";
				serverAliases = [ "www.mnogodobar.net" ];
				addSSL = true;
				enableACME = true;
				locations."/" = {
					proxyPass = "http://10.0.0.6:3000";
				};
			};		
			"cdn.mnogoodbar.net" = {
				serverName = "cdn.mnogodobar.net";
				addSSL = true;
				enableACME = true;
				locations = {
					"/" = {
						root =  "/mnt/public-share";
						extraConfig = ''
							autoindex on;
						'';
					};
					"/content-warning/" = {
						alias = "/mnt/nas-share-luka/multimedia/ostalo/content-warning-game/";
						extraConfig = ''
							autoindex on;
							auth_basic "Zabranjeno";
							auth_basic_user_file /etc/nginx-simple-auth/.htpasswd;
							
						'';		
					};
					"/algebra/" = {
						alias = "/mnt/public-share/algebra/";
						extraConfig = ''
							autoindex on;
							auth_basic "Zabranjeno";
							auth_basic_user_file /etc/nginx-simple-auth/.htpasswd;
						'';
					};
					"/iso/" = {
						alias = "/mnt/proxmox-backup/template/iso/";
						extraConfig = ''
							autoindex on;
						'';
					};
				};
			};
			"ftp.mnogodobar.net" = {
				addSSL = true;
				enableACME = true;
				serverName = "ftp.mnogodobar.net";
				serverAliases = [ "files.mnogodobar.net" ];
				locations = {
					"/" = {
						proxyPass = "http://10.0.0.30:8001/";
					};
				};
			};
			"iskra.mnogodobar.net" = {
				addSSL = true;
				enableACME = true;
				serverName = "iskra.mnogodobar.net";
				serverAliases = [ "www.iskra.mnogodobar.net" ];
				locations."/" = {
					proxyPass = "http://10.0.0.3:8000";
				};
			};
			"map.mc.mnogodobar.net" = {
				addSSL = true;
				enableACME = true;
				serverName = "map.mc.mnogodobar.net";
				locations."/" = {
					proxyPass = "http://10.0.0.7:8123";
				};
			};
			"z.com.hr" = {
				addSSL = true;
				enableACME = true;
				serverName = "z.com.hr";
				serverAliases = [ "www.z.com.hr" ];
				locations = {
					"/" = {
						proxyPass = "http://10.0.0.6:8000";
					};
				};
			};
			"benjbenj.z.com.hr" = {
				addSSL = true;
				enableACME = true;
				serverName = "benjbenj.z.com.hr";
				serverAliases = [ "www.benjbenj.z.com.hr" ];
				locations."/" = {
					root = "/mnt/public-share/web/html/benjbenj";
				};
			};
		};	
	};	
	security.acme = {
		acceptTerms = true;
		defaults.email = "admin@mnogodobar.net";
	};
}
