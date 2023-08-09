{config, ...}: let
  mbsync = "${config.programs.mbsync.package}/bin/mbsync";
  pass = "${config.programs.password-store.package}/bin/pass";

  common = rec {
    realName = "Daniel Xu";
    gpg = {
      key = "E832 5E51 5382 CDE4 3B9F  BE12 DDC4 DDB3 D659 ED62";
      signByDefault = true;
    };
    signature = {
      showSignature = "append";
      text = ''
        ${realName}

        https://aspectsides.site
        PGP: ${gpg.key}
      '';
    };
  };
in {
  accounts.email = {
    maildirBasePath = "Mail";
    accounts = {
      personal =
        rec {
          primary = true;
          address = "x0bas.dev@gmail.com";
          passwordCommand = "${pass} ${smtp.host}/${address}";

          imap.host = "imap.gmail.com";
          mbsync = {
            enable = true;
            create = "maildir";
            expunge = "both";
          };
          folders = {
            inbox = "Inbox";
            drafts = "Drafts";
            sent = "Sent";
            trash = "Trash";
          };
          neomutt = {
            enable = true;
            extraMailboxes = ["Archive" "Drafts" "Junk" "Sent" "Trash"];
          };

          msmtp.enable = true;
          smtp.host = "smtp.gmail.com";
          userName = address;
        }
        // common;

      school =
        rec {
          address = "dx86008@student.musd.org";
          passwordCommand = "${pass} ${smtp.host}/${address}";

          msmtp.enable = true;
          smtp.host = "smtp.gmail.com";
          userName = address;
        }
        // common;
    };
  };

  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
}
