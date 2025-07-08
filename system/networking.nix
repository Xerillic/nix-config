{
  hostName,
  lib,
  ...
}: {
  systemd.services.NetworkManager-wait-online.enable = lib.mkDefault false;

  networking = {
    networkmanager.enable = lib.mkDefault true;
    inherit hostName;
    firewall = {
      enable = lib.mkDefault true;
      # Common ports that might be needed (can be overridden per host)
      # allowedTCPPorts = [ 22 80 443 ];
      # allowedUDPPorts = [ 53 ];
    };
  };

  services = {
    avahi = {
      enable = lib.mkDefault true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
