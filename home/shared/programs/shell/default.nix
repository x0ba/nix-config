{
  config,
  flakePath,
  pkgs,
  ...
}: let
  symlink = fileName: {recursive ? false}: {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/${fileName}";
    recursive = recursive;
  };
in {
  programs = {
    btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };

    nix-index.enable = true;

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = ["--cmd cd"];
    };

    bat = {
      enable = true;
      config = {
        pager = "never";
        style = "plain";
        theme = "base16";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    lsd = {
      enable = true;
      enableAliases = true;
    };
  };

  xdg.configFile."lsd" = {
    source = ./lsd_config;
    recursive = true;
  };
}
