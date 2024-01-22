{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in {
  accounts.email.maildirBasePath = "${config.xdg.dataHome}/mail";

  accounts.email.accounts = {
    "personal" = {
      primary = true;
      address = "danielxu0307@gmail.com";
      userName = "danielxu0307@gmail.com";
      realName = "Daniel Xu";
      passwordCommand = "${pkgs.gopass}/bin/gopass -o mail/personal";
      maildir.path = "personal";

      aliases = ["danielxu0307@gmail.com"];

      imap = {
        host = "imap.gmail.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.gmail.com";
        port = 465;
        tls.enable = true;
      };

      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
      };

      msmtp.enable = true;
      neomutt = {enable = true;};
      notmuch.enable = true;
    };
  };

  home.packages = with pkgs; [w3m];

  programs = {
    mbsync.enable = true;
    msmtp.enable = true;
    neomutt = {
      enable = true;
      sidebar.enable = true;
      sort = "reverse-threads";
      vimKeys = true;
      extraConfig = "";
      settings = {
        mailcap_path = "$HOME/.config/neomutt/mailcap:$mailcap_path";
      };
      binds = [
        {
          map = ["index" "pager"];
          key = "i";
          action = "noop";
        }
        {
          map = ["index" "pager"];
          key = "g";
          action = "noop";
        }
        {
          map = ["index"];
          key = "\\Cf";
          action = "noop";
        }
        {
          map = ["index" "pager"];
          key = "M";
          action = "noop";
        }
        {
          map = ["index" "pager"];
          key = "C";
          action = "noop";
        }
        {
          map = ["index"];
          key = "gg";
          action = "first-entry";
        }
        {
          map = ["index"];
          key = "j";
          action = "next-entry";
        }
        {
          map = ["index"];
          key = "k";
          action = "previous-entry";
        }
        {
          map = ["attach"];
          key = "<return>";
          action = "view-mailcap";
        }
        {
          map = ["attach"];
          key = "l";
          action = "view-mailcap";
        }
        {
          map = ["editor"];
          key = "<space>";
          action = "noop";
        }
        {
          map = ["index"];
          key = "G";
          action = "last-entry";
        }
        {
          map = ["index"];
          key = "gg";
          action = "first-entry";
        }
        {
          map = ["pager" "attach"];
          key = "h";
          action = "exit";
        }
        {
          map = ["pager"];
          key = "j";
          action = "next-line";
        }
        {
          map = ["pager"];
          key = "k";
          action = "previous-line";
        }
        {
          map = ["pager"];
          key = "l";
          action = "view-attachments";
        }
        {
          map = ["index"];
          key = "D";
          action = "delete-message";
        }
        {
          map = ["index"];
          key = "U";
          action = "undelete-message";
        }
        {
          map = ["index"];
          key = "L";
          action = "limit";
        }
        {
          map = ["index"];
          key = "h";
          action = "noop";
        }
        {
          map = ["index"];
          key = "l";
          action = "display-message";
        }
        {
          map = ["index" "query"];
          key = "<space>";
          action = "tag-entry";
        }
        {
          map = ["browser"];
          key = "h";
          action = "goto-parent";
        }
        # { map = [ "browser" ]; key = "h"; action = "'<change-dir><kill-line>..<enter>' \"Go to parent folder\""; }
        {
          map = ["index" "pager"];
          key = "H";
          action = "view-raw-message";
        }
        {
          map = ["browser"];
          key = "l";
          action = "select-entry";
        }
        {
          map = ["browser"];
          key = "gg";
          action = "top-page";
        }
        {
          map = ["browser"];
          key = "G";
          action = "bottom-page";
        }
        {
          map = ["pager"];
          key = "gg";
          action = "top";
        }
        {
          map = ["pager"];
          key = "G";
          action = "bottom";
        }
        {
          map = ["index" "pager" "browser"];
          key = "d";
          action = "half-down";
        }
        {
          map = ["index" "pager" "browser"];
          key = "u";
          action = "half-up";
        }
        {
          map = ["index" "pager"];
          key = "S";
          action = "sync-mailbox";
        }
        {
          map = ["index" "pager"];
          key = "R";
          action = "group-reply";
        }
        {
          map = ["index"];
          key = "\\031";
          action = "previous-undeleted";
        }
        {
          map = ["index"];
          key = "\\005";
          action = "next-undeleted";
        }
        {
          map = ["pager"];
          key = "\\031";
          action = "previous-line";
        }
        {
          map = ["pager"];
          key = "\\005";
          action = "next-line";
        }
        {
          map = ["editor"];
          key = "<Tab>";
          action = "complete-query";
        }
      ];
    };
    notmuch.enable = true;
  };
}
