{...}: {
  systems = [
    "x86_64-linux"
    "aarch64-darwin"
  ];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        nil
        git
        alejandra
        deadnix
        gum
        home-manager
        age-plugin-yubikey
        nvfetcher
        statix
      ];
      DIRENV_LOG_FORMAT = "";
      shellHook = ''
        ${config.pre-commit.installationScript}
      '';
    };
  };
}
