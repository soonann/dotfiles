{config, pkgs, ...}: 
let
	immich_image =  "altran1502/immich-server:release";
	immich_data_dir = "/potatopool/media:/usr/src/app/upload";
	immich_env_file = "/potatopool/cache/secrets/immich/.env";
	pgsql_data_dir = "/potatopool/cache/appdata/immich-pgsql:/var/lib/postgresql/data";
	extraOptions = [
		"--network=immich-bridge"
	];
in
{

# immich container
	config.virtualisation.oci-containers.containers = {

# immich main server
		immich-server = {
			hostname = "immich-server";
			image = immich_image;
			ports = [ "2283:3001" ];
			volumes = [
				immich_data_dir
				"/etc/localtime:/etc/localtime:ro"
			];
			cmd = [
				"./start-server.sh"
			];
			environmentFiles = [
				immich_env_file
			];
			dependsOn = [
				"immich-redis"
				"immich-pgsql"
			]; 
			extraOptions = extraOptions;
		};

# immich microservices
		immich-microservice-01 = {
			hostname = "immich-microservice-01";
			image = immich_image;
			volumes = [
				immich_data_dir
				"/etc/localtime:/etc/localtime:ro"
			];
			cmd = [
				"./start-microservices.sh"
			];
			environmentFiles = [
				immich_env_file
			];
			dependsOn = [
				"immich-redis"
				"immich-pgsql"
				"immich-server"
			];
			extraOptions = extraOptions;
		};

		immich-redis = {
			hostname = "immich-redis";
			image = "redis:6.2-alpine@sha256:c5a607fb6e1bb15d32bbcf14db22787d19e428d59e31a5da67511b49bb0f1ccc";
			extraOptions = extraOptions;
		};	

		immich-pgsql = {
			hostname = "immich-pgsql";
			image = "tensorchord/pgvecto-rs:pg14-v0.1.11@sha256:0335a1a22f8c5dd1b697f14f079934f5152eaaa216c09b61e293be285491f8ee";
			environmentFiles = [
				immich_env_file
			];
			volumes = [
				pgsql_data_dir
			];
			extraOptions = extraOptions;

		};		
	};

	config.systemd.services.init-immich-network = {
		description = "Create the network bridge for immich.";
		after = [ "network.target" ];
		wantedBy = [ "multi-user.target" ];
		serviceConfig.Type = "oneshot";
		script = ''
		# Put a true at the end to prevent getting non-zero return code, which will
		# crash the whole service.
		check=$(${pkgs.podman}/bin/podman network ls | grep "immich-bridge" || true)
		if [ -z "$check" ];
		then ${pkgs.podman}/bin/podman network create immich-bridge
		else echo "immich-bridge already exists in docker"
		fi
		'';
	};
}
