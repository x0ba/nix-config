{
  lib,
  pkgs,
  ...
}: {
  # manipulate the global /etc/zshenv for PATH, etc.
  programs.zsh.enable = true;
  system.stateVersion = 4;

  security.pam.enableSudoTouchIdAuth = true;
  system.defaults.alf.stealthenabled = 1;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  services = {
    privoxy = {
      enable = true;
      config = ''
        # https://github.com/drduh/config/blob/master/privoxy/config
        # https://www.privoxy.org/user-manual/config.html
        #forward-socks5t / 127.0.0.1:9050 .  # forward to Tor
        #forward /  127.0.0.1:1234
        #listen-address 10.8.1.1:8118
        #listen-address 172.16.1.1:8118
        #listen-address 192.168.1.1:8118
        listen-address 127.0.0.1:8118
        toggle 1
        confdir /etc/privoxy
        actionsfile default.action
        actionsfile match-all.action
        actionsfile user.action
        filterfile default.filter
        filterfile user.filter
        logdir /var/log/privoxy
        logfile logfile
        accept-intercepted-requests 1
        allow-cgi-request-crunching 0
        enable-remote-http-toggle  0
        enable-remote-toggle  0
        enable-edit-actions 0
        enforce-blocks 0
        forwarded-connect-retries 0
        split-large-forms 0
        tolerate-pipelining 1
        default-server-timeout 10
        keep-alive-timeout 10
        socket-timeout 10
        buffer-limit 8192
        debug     1 # Log the destination for each request Privoxy let through. See also debug 1024.
        #debug     2 # show each connection status
        #debug     4 # show I/O status
        #debug     8 # show header parsing
        #debug    16 # log all data written to the network
        #debug    32 # debug force feature
        #debug    64 # debug regular expression filters
        #debug   128 # debug redirects
        #debug   256 # debug GIF de-animation
        #debug   512 # Common Log Format
        debug  1024 # Log the destination for requests Privoxy didn't let through, and the reason why.
        #debug  2048 # CGI user interface
        debug  4096 # Startup banner and warnings.
        debug  8192 # Non-fatal errors
        #debug 32768 # log all data read from the network
        #debug 65536 # Log the applying actions
      '';
    };
    yabai = {
      enable = true;
      package = pkgs.yabai.overrideAttrs (prev: {
        version = "6.0.1";
        src = pkgs.fetchzip {
          inherit (prev.src) url;
          hash = "sha256-CXkGVoJcGSkooxe7eIhwaM6FkOI45NVw5jdLJAzgFBM=";
        };
      });
      enableScriptingAddition = true;
      logFile = "/var/tmp/yabai.log";
      config = {
        # layout
        layout = "bsp";
        auto_balance = "off";
        split_ratio = "0.50";
        window_origin_display = "default";
        window_placement = "second_child";
        window_gap = 07;
        top_padding = 07;
        bottom_padding = 07;
        left_padding = 07;
        right_padding = 07;
        window_shadow = "off";
      };
      extraConfig = let
        rule = "yabai -m rule --add";
        ignored = app: builtins.concatStringsSep "\n" (map (e: ''${rule} app="${e}" manage=off sticky=off layer=above border=off'') app);
        unmanaged = app: builtins.concatStringsSep "\n" (map (e: ''${rule} app="${e}" manage=off'') app);
      in ''
        # auto-inject scripting additions
        yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
        sudo yabai --load-sa

        ${ignored ["JetBrains Toolbox" "ProtonVPN" "Stats" "1Password" "Pika" "LuLu Alert"]}
        ${unmanaged ["GOG Galaxy" "Steam" "System Settings" "VeraCrypt"]}
        yabai -m rule --add app="^1Password$" manage=off
        yabai -m rule --add app="^Stats$" manage=off
        yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
        yabai -m rule --add label="LuLu" app="^LuLu$" title="(Alert)" manage=off
        yabai -m rule app="^JetBrains Toolbox$" manage=off
        yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$" manage=off

        # etc.
        ${rule} manage=off border=off app="Shottr"
        ${rule} manage=off sticky=on  app="OBS Studio"
      '';
    };
    skhd = {
      enable = true;
      skhdConfig = let
        mapKeymaps = with builtins;
          cmd:
            concatStringsSep "\n" (map (i:
              replaceStrings ["Num"] [
                (toString (
                  if (i == 10)
                  then 0
                  else i
                ))
              ]
              cmd) (lib.range 1 10));
      in ''
        ctrl - left  : yabai -m space --focus prev
        ctrl - right : yabai -m space --focus next

        # send window to desktop and follow
        ${mapKeymaps "lalt + shift - Num : yabai -m window --space Num; yabai -m space --focus Num"}

        # switch to desktop
        ${mapKeymaps "lalt - Num : yabai -m space --focus Num"}

        # Window Navigation (through display borders): lalt - {h, j, k, l}
        lalt - h : yabai -m window --focus west  || yabai -m display --focus west
        lalt - j : yabai -m window --focus south || yabai -m display --focus south
        lalt - k : yabai -m window --focus north || yabai -m display --focus north
        lalt - l : yabai -m window --focus east  || yabai -m display --focus east

        # Float / Unfloat window: lalt - space
        lalt - space : yabai -m window --toggle float; sketchybar --trigger window_focus

        # Close focused window:
        lalt - q : yabai -m window --close

        # Make window zoom to fullscreen: shift + lalt - f
        shift + lalt - f : yabai -m window --toggle zoom-fullscreen; sketchybar --trigger window_focus

        # Make window zoom to parent node: lalt - f
        lalt - f : yabai -m window --toggle zoom-parent; sketchybar --trigger window_focus

        ## Window Movement (shift + lalt - ...)
        # Moving windows in spaces: shift + lalt - {h, j, k, l}
        shift + lalt - h : yabai -m window --warp west || $(yabai -m window --display west && sketchybar --trigger windows_on_spaces && yabai -m display --focus west && yabai -m window --warp last) || yabai -m window --move rel:-10:0
        shift + lalt - j : yabai -m window --warp south || $(yabai -m window --display south && sketchybar --trigger windows_on_spaces && yabai -m display --focus south) || yabai -m window --move rel:0:10
        shift + lalt - k : yabai -m window --warp north || $(yabai -m window --display north && sketchybar --trigger windows_on_spaces && yabai -m display --focus north) || yabai -m window --move rel:0:-10
        shift + lalt - l : yabai -m window --warp east || $(yabai -m window --display east && sketchybar --trigger windows_on_spaces && yabai -m display --focus east && yabai -m window --warp first) || yabai -m window --move rel:10:0

        # Toggle split orientation of the selected windows node: shift + lalt - s
        shift + lalt - s : yabai -m window --toggle split

        ## Resize (ctrl + lalt - ...)
        # Resize windows: ctrl + lalt - {h, j, k, l}
        ctrl + lalt - h    : yabai -m window --resize right:-100:0 || yabai -m window --resize left:-100:0
        ctrl + lalt - j    : yabai -m window --resize bottom:0:100 || yabai -m window --resize top:0:100
        ctrl + lalt - k    : yabai -m window --resize bottom:0:-100 || yabai -m window --resize top:0:-100
        ctrl + lalt - l : yabai -m window --resize right:100:0 || yabai -m window --resize left:100:0

        # Equalize size of windows: ctrl + lalt - e
        ctrl + lalt - e : yabai -m space --balance

        # Enable / Disable gaps in current workspace: ctrl + lalt - g
        ctrl + lalt - g : yabai -m space --toggle padding; yabai -m space --toggle gap

        lalt - return : open -na "''${HOME}/Applications/Home Manager Apps/WezTerm.app"
        lalt - e : emacsclient -c
      '';
    };
  };
}
