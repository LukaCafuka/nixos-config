{ config, pkgs, ... }:

let
statusConfig = ''
	error_page 401 /401.html;
	error_page 403 /403.html;
	error_page 404 /404.html;
	error_page 502 /502.html;
	charset utf-8;
'';

statusLocation = "~^/(401.html|403.html|404.html|502.html)";

in {
	services.nginx = {
		enable = true;
		statusPage = true;
		virtualHosts = {
			"default" = {
				default = true;
				listen = [
					{ 
						addr = "0.0.0.0"; 
						port = 80;
					} 
					
				];
				locations = {
					"/" = {
						return = "404";
					};
					"~^/(401.html|403.html|404.html|502.html)" = {
						root = "/etc/nixos/nginx/status/";
					};
				};
				extraConfig = statusConfig; 
			};
			"mnogodobar.net" = {
				serverName = "mnogodobar.net";
				serverAliases = [ "www.mnogodobar.net" ];
				addSSL = true;
				enableACME = true;
				locations."~^/(401.html|403.html|404.html|502.html)" = {
					root = "/etc/nixos/nginx/status/";
				};
				locations."/" = {
					proxyPass = "http://10.0.0.6:3000";
				};
				extraConfig = statusConfig;
			};		
			"cdn.mnogoodbar.net" = {
				serverName = "cdn.mnogodobar.net";
				addSSL = true;
				enableACME = true;
				locations = {
					"~^/(401.html|403.html|404.html|502.html)" = {
						root = "/etc/nixos/nginx/status/";
					};
					"/" = {
						root =  "/mnt/public-share";
						extraConfig = ''
							autoindex on;
							charset utf-8;
						'';
					};
					"/content-warning/" = {
						alias = "/mnt/nas-share-luka/multimedia/ostalo/content-warning-game/";
						extraConfig = ''
							autoindex on;
							auth_basic "Zabranjeno";
							auth_basic_user_file .htpasswd;
							
						'';		
					};
					"/algebra/" = {
						alias = "/mnt/public-share/algebra/";
						extraConfig = ''
							autoindex on;
							charset utf-8;
							auth_basic "Zabranjeno";
							auth_basic_user_file .htpasswd;
						'';
					};
					"/iso/" = {
						alias = "/mnt/proxmox-backup/template/iso/";
						extraConfig = ''
							autoindex on;
						'';
					};
				};
				extraConfig = statusConfig;
			};
			"ftp.mnogodobar.net" = {
				forceSSL = true;
				enableACME = true;
				serverName = "ftp.mnogodobar.net";
				serverAliases = [ "files.mnogodobar.net" ];
				locations = {
					"~^/(401.html|403.html|404.html|502.html)"= {
						root = "/etc/nixos/nginx/status/";
					};

					"/" = {
						proxyPass = "http://10.0.0.30:8001/";
					};
				};
				extraConfig = statusConfig;
			};
			"iskra.mnogodobar.net" = {
				addSSL = true;
				enableACME = true;
				serverName = "iskra.mnogodobar.net";
				serverAliases = [ "www.iskra.mnogodobar.net" ];
				locations."~^/(401.html|403.html|404.html|502.html)"= {
					root = "/etc/nixos/nginx/status/";
				};
				locations."/" = {
					proxyPass = "http://10.0.0.19:8000";
				};
				extraConfig = statusConfig;
			};
			"map.mc.mnogodobar.net" = {
				addSSL = true;
				enableACME = true;
				serverName = "map.mc.mnogodobar.net";
				locations."~^/(401.html|403.html|404.html|502.html)"= {
					root = "/etc/nixos/nginx/status/";
				};
				locations."/" = {
					proxyPass = "http://10.0.0.7:8123";
				};
				extraConfig = statusConfig;
			};
			"z.com.hr" = {
				forceSSL = true;
				enableACME = true;
				serverName = "z.com.hr";
				serverAliases = [ "www.z.com.hr" ];
				locations = {
					"~^/(401.html|403.html|404.html|502.html)"= {
						root = "/etc/nixos/nginx/status/";
					};
					"/" = {
						proxyPass = "http://10.0.0.22:8000";
					};
				};
				extraConfig = statusConfig;
			};
			"benjbenj.z.com.hr" = {
				addSSL = true;
				enableACME = true;
				serverName = "benjbenj.z.com.hr";
				serverAliases = [ "www.benjbenj.z.com.hr" ];
				locations."~^/(401.html|403.html|404.html|502.html)"= {
					root = "/etc/nixos/nginx/status/";
				};

				locations."/" = {
					root = "/mnt/public-share/web/html/benjbenj";
				};
				extraConfig = statusConfig;
			};
			"music.z.com.hr".locations."/" = {
				return = "307 https://cdn.mnogodobar.net/music/";
			};
			"webdav.nas.mnogodobar.net" = {
				forceSSL = true;
				enableACME = true;
				serverName = "webdav.nas.mnogodobar.net";
				locations = {
					"/" = {
						proxyPass = "https://10.0.0.5:5006";
					};
				};
			};
		};
	};
	security.acme = {
		acceptTerms = true;
		defaults.email = "admin@mnogodobar.net";
	};
}
