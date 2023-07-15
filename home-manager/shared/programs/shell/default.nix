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
    
    zoxide.enable = true;

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

    nix-index.enable = true;

  };

  xdg.configFile = {
    "lsd" = symlink "../../../../config/lsd" {recursive = true;};
  };
}
