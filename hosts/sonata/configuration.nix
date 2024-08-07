{
  config,
  lib,
  pkgs,
  ...
}:
/*
  NixOS configuration

  Useful links:
  - Package Search: https://search.nixos.org/packages?channel=unstable
  - Options Search: https://search.nixos.org/options?channel=unstable
*/
{
  imports = [
    ./hardware-configuration.nix

    # Append your custom NixOS modules in this list
    # ../../modules/nixos/programs/river.nix
  ];

  boot = {
    kernelModules = [ "amd-pstate" ];

    kernelParams = [
      "amd_pstate=passive"
      "amd_pstate.shared_mem=1"
      "initcall_blacklist=acpi_cpufreq_init"
    ];
  };

  hardware = {
    cpu.amd.updateMicrocode = true;

    /*
      hardware-configuration.nix enables this by default because of this line:

      >  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

      See https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/installer/scan/not-detected.nix
    */
    enableRedistributableFirmware = true;

    nvidia = {
      modesetting.enable = true;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  # Font packages should go in fonts.packages in ../shared/configuration.nix.
  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      NVD_BACKEND = "direct";
      LIBVA_DRIVER_NAME = "nvidia";
      MOZ_DISABLE_RDD_SANDBOX = "1";
      MOZ_GLX_TEST_EARLY_WL_ROUNDTRIP = "1";
    };

    systemPackages = lib.attrValues {
      inherit (pkgs)
        file
        ntfs3g
        pavucontrol
        pulseaudio
        ripgrep
        util-linux
        unrar
        unzip
        xarchiver
        zip
        ;

      inherit (pkgs.qt5) qtwayland;
      inherit (pkgs.gnome3) nautilus;
    };
  };

  fonts.enableDefaultPackages = false;

  networking = {
    firewall = {
      allowedTCPPorts = [
        445
        139
      ];
      allowedUDPPorts = [
        137
        138
      ];
    };

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  # https://github.com/nix-community/home-manager/issues/1288#issuecomment-636352427
  programs.sway.enable = true;

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;

      publish = {
        enable = true;
        addresses = true;
        domain = true;
        hinfo = true;
        userServices = true;
        workstation = true;
      };

      extraServiceFiles = {
        smb = ''
          <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
          <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
          <service-group>
            <name replace-wildcards="yes">%h</name>
            <service>
              <type>_smb._tcp</type>
              <port>445</port>
            </service>
          </service-group>
        '';
      };
    };

    greetd = {
      enable = true;

      settings =
        let
          sway-cmd = lib.concatStringsSep [
            (lib.getExe config.programs.sway.package)
            "--unsupported-gpu"
          ];
        in
        {
          default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd '${sway-cmd}'";

          initial_session = {
            command = "${sway-cmd}";
            user = "daniel";
          };
        };
    };

    samba = {
      enable = true;

      # You will still need to set up the user accounts to begin with:
      # $ sudo smbpasswd -a yourusername

      # This adds to the [global] section:
      extraConfig = ''
        browseable = yes
        smb encrypt = required
      '';

      shares = {
        homes = {
          browseable = "no";
          "read only" = "no";
          "guest ok" = "no";
        };
      };
    };

    samba-wsdd.enable = true;

    xserver.videoDrivers = [ "nvidia" ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}
