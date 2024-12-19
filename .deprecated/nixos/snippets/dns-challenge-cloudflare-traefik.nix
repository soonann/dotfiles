{pkgs, config}: {

  # dns validation using cloudflare credentials
  security.acme = {
    acceptTerms = true;
    defaults.email = "sudo@soonann.dev";
    certs."soonann.dev" = {
      domain = "soonann.dev";
      extraDomainNames = [ "*.soonann.dev" ];
      dnsProvider = "cloudflare";
      credentialsFile = "/potatopool/secrets/cloudflare/acme-credentials";
      # https://go-acme.github.io/lego/dns/cloudflare/
      # acme-credentials contents example:
      # CLOUDFLARE_EMAIL=you@example.com
      # CLOUDFLARE_API_KEY=b9841238feb177a84330febba8a83208921177bffe733 
    };
  };

  # add the following into your dynamic config for traefik
  # take note of the directory and file's permissions, traefik might not be
  # able to read them at runtime
  #tls = {
  #  stores.default = {
  #    defaultCertificate = {
  #      certFile = "/var/lib/acme/soonann.dev/cert.pem";
  #      keyFile = "/var/lib/acme/soonann.dev/key.pem";
  #    };
  #  };
  #  certificates = [
  #    {
  #      certFile = "/var/lib/acme/soonann.dev/cert.pem";
  #      keyFile = "/var/lib/acme/soonann.dev/key.pem";
  #      stores = "default";
  #    }
  #  ];
  #};
}
