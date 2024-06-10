{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    	home-manager = {
      		url = "github:nix-community/home-manager";
       		inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let 
      	system = "x86_64-linux";
      	pkgs = nixpkgs.legacyPackages.${system};
	user = "luka";
    in
    {
    nixosConfigurations.vege = nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {inherit inputs self user;};
            modules = [
        	./configuration.nix
		#home-manager.nixosModules.home-manager
		#{
		#	home-manager.useGlobalPkgs = true;
		#	home-manager.useUserPackages = true;
		#	home-manager.users.luka = import ./home.nix;
		#	home-manager.extraSpecialArgs = {inherit inputs self user;};
		#}

		];
    };
    };
}
