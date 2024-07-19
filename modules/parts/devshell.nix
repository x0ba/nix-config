{ ... }:
{
  systems = [
    "x86_64-linux"
    "aarch64-darwin"
  ];

  perSystem =
    {
      config,
      self',
      pkgs,
      ...
    }:
    {
      devShells.default = pkgs.mkShell {
        packages =
          with pkgs;
          [
            nil
            git
            alejandra
            lua-language-server
            deadnix
            git-crypt
            home-manager
            age-plugin-yubikey
            nvfetcher
            statix
          ]
          ++ [ self'.formatter ];
        DIRENV_LOG_FORMAT = "";
        shellHook = ''
          ${config.pre-commit.installationScript}
        '';
      };
    };
}
