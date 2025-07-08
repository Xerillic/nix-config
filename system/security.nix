{lib, ...}: {
  security = {
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
            if (
                subject.isInGroup("wheel") && (
                    action.id == "org.freedesktop.login1.suspend" ||
                    action.id == "org.freedesktop.login1.hibernate" ||
                    action.id == "org.freedesktop.login1.power-off" ||
                    action.id == "org.freedesktop.login1.reboot" ||
                    action.id == "org.freedesktop.NetworkManager.settings.modify.system" ||
                    action.id == "org.freedesktop.udisks2.filesystem-mount" ||
                    action.id == "org.freedesktop.udisks2.filesystem-unmount"
                )
            ) {
                return polkit.Result.YES;
            }
        });
      '';
    };

    sudo = {
      enable = true;
      wheelNeedsPassword = lib.mkDefault false;
      extraRules = [
        {
          groups = ["wheel"];
          commands = [
            {
              command = "/run/current-system/sw/bin/nixos-rebuild";
              options = ["NOPASSWD"];
            }
            {
              command = "/run/current-system/sw/bin/nix-collect-garbage";
              options = ["NOPASSWD"];
            }
          ];
        }
      ];
    };

    pam = {
      services = {
        login.limits = [
          {
            domain = "@wheel";
            type = "soft";
            item = "nofile";
            value = "65536";
          }
        ];
      };
    };
  };
}
