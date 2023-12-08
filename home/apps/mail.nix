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
      address = "x0ba@fastmail.com";
      userName = "x0ba@fastmail.com";
      realName = "Daniel Xu";
      primary = true;
      passwordCommand = "${pkgs.gopass}/bin/gopass -o mail/personal";
      maildir.path = "personal";

      aliases = ["hey@x0ba.lol"];

      imap = {
        host = "imap.fastmail.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.fastmail.com";
        port = 465;
        tls.enable = true;
      };

      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
      };

      imapnotify = {
        enable = true;
        onNotify = "${pkgs.isync}/bin/mbsync %s";
        onNotifyPost = "${pkgs.notmuch}/bin/notmuch new && ${pkgs.libnotify}/bin/libnotify 'New mail arrived'";
      };

      msmtp.enable = true;
      neomutt = {
        enable = true;
      };
      notmuch.enable = true;
    };
  };

  home.packages = with pkgs; [w3m];

  services.imapnotify.enable = isLinux;

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
    };
    notmuch.enable = true;
  };
}
