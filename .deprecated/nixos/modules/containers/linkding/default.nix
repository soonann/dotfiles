{config, pkgs, ...}: 
let
	linkding_image =  "sissbruecker/linkding:latest";
	linkding_data_dir = "/cachepool/appdata/linkding/data:/etc/linkding/data";
	linkding_env_file = "/cachepool/secrets/linkding/.env";
in
{

# linkding container
	config.virtualisation.oci-containers.containers = {

# linkding main server
		linkding-server = {
			hostname = "linkding";
			image = linkding_image;
			ports = [ "9090:9090" ];
			volumes = [
				linkding_data_dir
			];
			environmentFiles = [
				linkding_env_file
			];
		};
	};

}
