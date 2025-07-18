{pkgs, ...}: let
  # userList = ["rocco"]; # Specify users
  userList = builtins.attrNames (builtins.readDir ../../users); # All users

  mkDotfileUnit = username: let
    dotfilesDir = ../../users/${username}/home;
  in
    if builtins.pathExists dotfilesDir
    then {
      name = "seed-dotfiles-${username}";
      value = {
        description = "Seed dotfiles for ${username}";
        wantedBy = ["multi-user.target"];
        serviceConfig = {
          Type = "oneshot";
          User = username;
          ExecStart = "${pkgs.rsync}/bin/rsync -a ${dotfilesDir}/ /home/${username}/";
          ExecStartPost = "${pkgs.coreutils}/bin/touch /home/${username}/.dotfiles_seeded";
        };
        unitConfig = {
          ConditionPathExists = "!/home/${username}/.dotfiles_seeded";
        };
      };
    }
    else null;
  units = builtins.filter (x: x != null) (map mkDotfileUnit userList);
in {
  imports = map (u: ../../users/${u}/user.nix) userList;
  systemd.services = builtins.listToAttrs units;
}
