{ pkgs, ... }: {
  xdg.configFile."lf/icons".source = ./lf/icons;
  programs.lf = {
    enable = true;
    commands = {
      trash = ''
        ''${{
            ${pkgs.trash-cli}/bin/trash-put "$f"
          }}
      '';
      mkdir = ''
        ''${{
          printf 'Directory Name: '
          read ans
          mkdir $ans
        }}
      '';
      mkfile = ''
        ''${{
          printf 'File Name: '
          read ans
        }}
      '';
      open = ''
        ''${{
          case $(file --mime-type $f -b) in
              text/*) nvim $fx;;
              *) for f in $fx; do setsid $OPENER $f > /dev/null 2> /dev/null & done;;
          esac
        }}
      '';
      unarchive = ''
        ''${{
          case "$f" in
              *.zip) unzip "$f" ;;
              *.tar.gz) tar -xzvf "$f" ;;
              *.tar.bz2) tar -xjvf "$f" ;;
              *.tar) tar -xvf "$f" ;;
              *) echo "Unsupported format" ;;
          esac
        }}
      '';
      restore_trash = ''
        ''${{
            ${pkgs.trash-cli}/bin/trash-restore
        }}
      '';
    };
    settings = {
      hidden = true;
      preview = true;
      icons = true;
      ignorecase = true;
    };
    previewer.source = "${pkgs.nur.repos.x0ba.preview}/bin/preview";
    keybindings = {
      d = "";
      m = "";
      o = "open $f";
      gh = "cd ~";
      gm = "cd ~/Music/";
      gD = "cd ~/Downloads/";
      gd = "cd ~/Documents/";
      gc = "cd ~/.config/nixpkgs";
      gC = "cd ~/Code";
      gp = "cd ~/Pictures";
      au = "unarchive";
      dd = "trash";
      du = "trash-restore";
      x = "cut";
      mf = "mkfile";
      md = "mkdir";
    };
  };
}
