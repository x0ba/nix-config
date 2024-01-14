{...}: {
  programs = {
    atuin = {
      enable = true;
      flags = ["--disable-up-arrow"];
      settings = {
        inline_height = 30;
        style = "compact";
      };
    };

    btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };

    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    fzf = {
      enable = true;
      defaultOptions = ["--height=30%" "--layout=reverse" "--info=inline"];
    };

    lsd = {
      enable = true;
      enableAliases = true;
      settings = {
        classic = false;
        blocks = ["permission" "user" "group" "size" "date" "name"];
        date = "+%y.%m.%d %H:%M";
        dereference = false;
        ignore-globs = [".git"];
        color = {
          when = "auto";
          theme = "custom";
        };
        icons = {
          when = "auto";
          theme = "fancy";
          separator = " ";
        };
        header = false;
        hyperlink = "auto";
        indicators = true;
        layout = "grid";
        permission = "octal";
        size = "default";
        sorting = {
          column = "name";
          dir-grouping = "first";
        };
        symlink-arrow = "󰌷";
      };
    };

    nix-index.enable = true;

    tealdeer = {
      enable = true;
      settings = {
        style = {
          description.foreground = "white";
          command_name.foreground = "green";
          example_text.foreground = "blue";
          example_code.foreground = "white";
          example_variable.foreground = "yellow";
        };
        updates.auto_update = true;
      };
    };

    zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };

    bat.enable = true;
  };
}
