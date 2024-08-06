{ ... }:
{
  systems = [
    "x86_64-linux"
    "aarch64-darwin"
  ];

  perSystem =
    {
      config,
      lib,
      inputs',
      self',
      pkgs,
      ...
    }:
    {
      devShells.default = pkgs.mkShellNoCC {
        packages =
          with pkgs;
          [
            nixd
            nix-output-monitor
            nvd
            git
            just
            lua-language-server
            deadnix
            git-crypt
            home-manager
            age-plugin-yubikey
            nvfetcher
          ]
          ++ [ self'.formatter ]
          ++ lib.optionals pkgs.stdenv.isDarwin [ inputs'.darwin.packages.darwin-rebuild ];
        DIRENV_LOG_FORMAT = "";
        shellHook = ''
          ${config.pre-commit.installationScript}
        '';
      };
    };
}
