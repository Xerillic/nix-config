{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "rocco";
  home.homeDirectory = "/home/rocco";

  programs.bash.enable = true;
  home.sessionVariables = {
    EDITOR = "micro";
    VISUAL = "micro";
    TERMINAL = "kitty";
    SHELL = "fish";
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      #{ name = "grc"; src = pkgs.fishPlugins.grc.src; }
    ];
  };

  programs.mangohud = {
  	enable = true;
  	enableSessionWide = false;
  	settings = {
  		full = true;
  	};
  };
  services.spotifyd = {
    enable = true;
    settings =
      {

      };
  };
  services.kdeconnect.enable = true;

  
  programs.kitty = {
  	enable = true;
  	extraConfig = ''
    font_family Jetbrains-mono
    font_size 13.0
    bold_font auto
    italic_font auto
    bold_italic_font auto
    
    background_opacity 0.7
    confirm_os_window_close 0
    
    # change to x11 or wayland or leave auto
    linux_display_server auto
    
    scrollback_lines 2000
    wheel_scroll_min_lines 1
    
    enable_audio_bell no
    
    window_padding_width 4
    
    selection_foreground none
    selection_background none
    
    foreground #dddddd
    background #000000
    cursor #dddddd
  	'';
  };

  home.pointerCursor = {
    name = "Adwaita";
    size = 24;
    package = pkgs.adwaita-icon-theme;
  };


  services.kanshi = {
    enable = true;
  	settings = [{
      profile.name = "main";
  	  profile.outputs = [{
	    status = "enable";
		criteria = "DP-3";
		position = "0,0";
		mode = "1920x1080@60Hz";
		transform = "90";
	  }{
	    status = "enable";
		criteria = "DP-1";
		position = "1080,200";
		mode = "2560x1440@143.912Hz";
		adaptiveSync = true;
	  }];
    }];
  };

  services.mako = {
  	enable = true;
  	font = "Jetbrains-mono 11";
    anchor = "bottom-right";
    width=350;
    padding="10";
    margin="10";
    borderSize=2;
    defaultTimeout=5000;
    
    # Only for desktop, ignored when no such output exists
    output="DP-1";
    
    backgroundColor="#231f20";
    borderColor= "#009ddc";
    textColor="#d9d8d8";

    ignoreTimeout=true;
  };
  
  services.gnome-keyring.enable = true;
  wayland.windowManager.sway = {
    package = pkgs.sway;
    checkConfig = false;
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    config = {
      modifier = "Mod4";
      terminal = "kitty";
      bars = [
        {command = "waybar";}
      ];
      startup = [
        {command = "nm-applet";}
        {command = "blueman-applet";}
        {command = "udiskie";}
        {command = "kdeconnectd";}
        {command = "kdeconnect-indicator";}
      ];
    };
    extraConfig = ''
		exec wl-paste -t text --watch clipman store --no-persist
		exec sleep 5; systemctl --user start kanshi.service
		exec sleep 5; xrandr --output DP-1 --primary

		# Variables
		set $mod Mod4
		set $screenshot grim ~/Pictures/screenshots/scrn-$(date +"%Y-%m-%d-%H-%M-%S").png
		set $screenclip slurp | grim -g - ~/Pictures/screenshots/scrn-$(date +"%Y-%m-%d-%H-%M-%S").png
		set $cl_high #009ddc
		set $cl_indi #d9d8d8
		set $cl_back #231f20
		set $cl_fore #d9d8d8
		set $cl_urge #ee2e24
		set $opacity 0.7
		#for_window [app_id="vesktop"] opacity $opacity

		# Colors                border   bg       text     indi     childborder
		client.focused          $cl_high $cl_high $cl_fore $cl_indi $cl_high
		client.focused_inactive $cl_back $cl_back $cl_fore $cl_back $cl_back
		client.unfocused        $cl_back $cl_back $cl_fore $cl_back $cl_back
		client.urgent           $cl_urge $cl_urge $cl_fore $cl_urge $cl_urge

		# workspaces
		set $ws1   1:
		set $ws2   2:
		set $ws3   3:3
		set $ws4   4:4
		set $ws5   5:5
		set $ws6   6:6
		set $ws7   7:7
		set $ws8   8:8
		set $ws9   9:9
		set $ws0   10:10
		set $wsF1  11:
		set $wsF2  12:
		set $wsF3  13:13
		set $wsF4  14:14
		set $wsF5  15:15
		set $wsF6  16:16
		set $wsF7  17:17
		set $wsF8  18:
		set $wsF9  19:19
		set $wsF10 20:20
		set $wsF11 21:
		set $wsF12 22:

		# Window borders
		default_border pixel 1
		default_floating_border normal
		hide_edge_borders smart
		smart_gaps on
		gaps inner 10

		# Input configuration
		bindsym $mod+g exec steam
		bindsym $mod+o exec google-chrome-stable
		bindsym $mod+Shift+s exec $screenclip
		bindsym $mod+Print exec $screenshot
		bindsym XF86AudioRaiseVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'
		bindsym XF86AudioLowerVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'
		bindsym XF86AudioMute exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'

		# Output configuration
		exec_always kill swaybg
		exec_always swaybg -o DP-3 -m fill -i ~/.config/sway/left.jpg -o DP-1 -i ~/.config/sway/right.jpg 

		set $mode_system System: (e) logout, (s) suspend, (r) reboot, (S) shutdown, (R) UEFI
		mode "$mode_system" {
		    bindsym e exit
		    bindsym s exec --no-startup-id systemctl suspend, mode "default"
		    bindsym r exec --no-startup-id systemctl reboot, mode "default"
		    bindsym Shift+s exec --no-startup-id systemctl poweroff -i, mode "default"
		    bindsym Shift+r exec --no-startup-id systemctl reboot --firmware-setup, mode "default"

		    # return to default mode
		    bindsym Return mode "default"
		    bindsym Escape mode "default"
		}
		bindsym $mod+Shift+e mode "$mode_system"
      '';
  };
  programs.waybar = {
  	enable = true;
  	style = ./waybar/style.css;
  	settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [
          "sway/mode"
          "sway/workspaces"
          "custom/arrow11"
          "sway/window"
        ];

        modules-right = [
          "custom/arrow10"
          "idle_inhibitor"
          "custom/arrow9"
          "pulseaudio"
          "custom/arrow8"
          "network"
          "custom/arrow7"
          "memory"
          "custom/arrow6"
          "cpu"
          "custom/arrow5"
          "temperature"
          "custom/arrow4"
          "battery"
          "custom/arrow3"
          "sway/language"
          "custom/arrow2"
          "tray"
          "clock#date"
          "custom/arrow1"
          "clock#time"
        ];

        battery = {
          interval = 10;
          states = {
            warning = 30;
            critical = 15;
          };
          format-time = "{H}:{M:02}";
          format = "{icon} {capacity}% ({time})";
          format-charging = " {capacity}% ({time})";
          format-charging-full = " {capacity}%";
          format-full = "{icon} {capacity}%";
          format-alt = "{icon} {power}W";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip = false;
        };

        "clock#time" = {
          interval = 10;
          format = "{:%H:%M}";
          tooltip = false;
        };

        "clock#date" = {
          interval = 20;
          format = "{:%e %b %Y}";
          tooltip = false;
        };

        cpu = {
          interval = 5;
          tooltip = false;
          format = " {usage}%";
          format-alt = " {load}";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        "sway/language" = {
          format = " {}";
          min-length = 5;
          on-click = "${pkgs.sway}/bin/swaymsg 'input * xkb_switch_layout next'";
          tooltip = false;
        };

        memory = {
          interval = 5;
          format = " {used:0.1f}G/{total:0.1f}G";
          states = {
            warning = 70;
            critical = 90;
          };
          tooltip = false;
        };

        network = {
          interval = 5;
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = " {ifname}";
          format-disconnected = "No connection";
          format-alt = " {ipaddr}/{cidr}";
          tooltip = false;
        };

        "sway/mode" = {
          format = "{}";
          tooltip = false;
        };

        "sway/window" = {
          foramt = "{}";
          max-length = 30;
          tooltip = false;
        };

        "sway/workspaces" = {
          disable-scroll-wraparound = true;
          smooth-scrolling-threshold = 4;
          enable-bar-scroll = true;
          format = "{name}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" ];
          };
          scroll-step = 1;
          on-click = "${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
          tooltip = false;
        };

        temperature = {
          critical-threshold = 90;
          interval = 5;
          format = "{icon} {temperatureC}°";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip = false;
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = false;
        };

        tray = {
          icon-size = 18;
        };

        "custom/arrow1" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow2" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow3" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow4" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow5" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow6" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow7" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow8" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow9" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow10" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow11" = {
          format = "";
          tooltip = false;
        };
      };
    };
  };
  
  # The home.packages option allows you to install Nix packages into your
  # environment.
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    
    nnn
    micro
    
    libsForQt5.breeze-icons
    xfce.thunar
    google-chrome
    osu-lazer-bin
    prismlauncher
    vesktop
    
    
    android-tools
    tytools
    gamemode
    fastfetch
    scrcpy
    grim
    slurp 
    swayidle 
    swaylock 
    wmenu
    swaybg
    networkmanagerapplet
    wl-clipboard
    clipman
    blueman
    xorg.xrandr
    wdisplays
    pavucontrol
    webcord

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/rocco/etc/profile.d/hm-session-vars.sh
  #
  
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
  programs.home-manager.enable = true; # Let Home Manager install and manage itself.
}
