{
  inputs,
  pkgs,
  system,
  ...
}: {
  imports = [./brew.nix];

  programs = {
    fish.enable = true;
    zsh.enable = true;
  };

  security.pam.enableSudoTouchIdAuth = true;

  # services.emacs = {
  #   enable = true;
  #   package = pkgs.emacs;
  # };

  system = {
    defaults = {
      alf = {
        stealthenabled = 1;
        globalstate = 1;
      };
      finder = {
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = true;
      };
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        InitialKeyRepeat = 10;
        KeyRepeat = 1;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };
      dock = {
        autohide = true;
        show-recents = false;
        showhidden = true;
        launchanim = true;
        mru-spaces = false;
        mouse-over-hilite-stack = true;
        orientation = "left";
        tilesize = 48;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  # launchd.agents.dnscrypt-proxy = {
  #   serviceConfig.RunAtLoad = true;
  #   serviceConfig.KeepAlive = true;
  #   serviceConfig.ProgramArguments = [
  #     "${pkgs.dnscrypt-proxy2}/bin/dnscrypt-proxy"
  #     "-config"
  #     (toString (pkgs.writeText "dnscrypt-proxy.toml" ''
  #       server_names = ["mullvad"]
  #       listen_addresses = ["127.0.0.1:53"]
  #       ignore_system_dns = true
  #       [static.mullvad]
  #       stamp = "sdns://AgcAAAAAAAAACzE5NC4yNDIuMi4yAA9kbnMubXVsbHZhZC5uZXQKL2Rucy1xdWVyeQ"
  #     ''))
  #   ];
  # };

  # networking = {
  #   dns = [
  #     "127.0.0.1"
  #   ];
  #   knownNetworkServices = [
  #     "Wi-Fi"
  #     "Thunderbolt Bridge"
  #   ];
  # };

  nix = {
    gc = {
      user = "root";
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };
  };

  system.checks.verifyNixPath = false;
  services.nix-daemon.enable = true;

  fonts = {
    packages = with pkgs;
      [
        (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
        ibm-plex
        alegreya
        inter
        atkinson-hyperlegible
      ]
      ++ [inputs.apple-fonts.packages.${pkgs.system}.sf-mono];
  };
}
