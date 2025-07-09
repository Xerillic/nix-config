{...}: let
  username = builtins.baseNameOf (toString ./.);
in {
  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    extraGroups = ["wheel" "audio" "video" "networkmanager"];
  };
}
