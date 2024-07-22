{
  config,
  pkgs,
  lib,
  ...
}:
{
  home = {
    activation = {
      installCustomFonts =
        let
          fontDirectory =
            if pkgs.stdenv.isDarwin then
              "${config.home.homeDirectory}/Library/Fonts"
            else
              "${config.xdg.dataHome}/fonts";
          fontPath = ../../secrets/fonts;
        in
        lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          mkdir -p "${fontDirectory}"
          install -Dm644 ${fontPath}/* "${fontDirectory}"
        '';
    };
    packages = with pkgs; [
      coreutils-prefixed
      curl
      fd
      ffmpeg
      gnugrep
      jq
      nil
      lazygit
      pandoc
      pfetch
      pinentry_mac
      ripgrep

      # fonts
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      ibm-plex
      alegreya
      inter
      atkinson-hyperlegible
    ];
    sessionVariables = {
      MODULAR_HOME = "/Users/daniel/.local/share/modular";
      SSH_AUTH_SOCK = "${config.programs.gpg.homedir}/S.gpg-agent.ssh";
    };
  };

  programs = {
    firefox = {
      enable = true;
      package = (pkgs.writeScriptBin "__dummy-firefox" "");
      profiles.default = {
        search.default = "DuckDuckGo";
        search.force = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          multi-account-containers
          temporary-containers
        ];
        settings = {
          "app.normandy.first_run" = false;
          "app.update.auto" = false;
          "browser.contentblocking.category" = "custom";
          "browser.download.useDownloadDir" = false;
          "browser.formfill.enable" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.placeholderName" = "DuckDuckGo";
          "datareporting.healthreport.uploadEnabled" = false;
          "doh-rollout.disable-heuristics" = true;
          "dom.forms.autocomplete.formautofill" = true;
          "dom.security.https_only_mode_ever_enabled" = true;
          "dom.security.https_only_mode" = true;
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "extensions.pocket.enabled" = false;
          "identity.fxaccounts.enabled" = false;
          "layout.spellcheckDefault" = 1;
          "media.peerconnection.enabled" = false;
          "network.cookie.cookieBehavior" = 1;
          "network.cookie.lifetimePolicy" = 2;
          "network.proxy.socks_remote_dns" = true;
          "network.trr.custom_uri" = "https://doh.mullvad.net/dns-query";
          "network.trr.mode" = 3;
          "network.trr.uri" = "https://doh.mullvad.net/dns-query";
          "places.history.enabled" = false;
          "privacy.donottrackheader.enabled" = true;
          "privacy.history.custom" = true;
          "privacy.sanitize.sanitizeOnShutdown" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "signon.management.page.breach-alerts.enabled" = false;
          "signon.rememberSignons" = false;
          "accessibility.force_disabled" = 1;
          "app.normandy.api_url" = "";
          "app.normandy.enabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "beacon.enabled" = false;
          "browser.pagethumbnails.capturing_disabled" = true;
          "browser.ping-centre.telemetry" = false;
          "browser.places.speculativeConnect.enabled" = false;
          "browser.sessionstore.privacy_level" = 2;
          "browser.ssl_override_behavior" = 1;
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.uitour.enabled" = false;
          "browser.uitour.url" = "";
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.trimURLs" = false;
          "browser.xul.error_pages.expert_bad_cert" = true;
          "captivedetect.canonicalURL" = "";
          "datareporting.policy.dataSubmissionEnabled" = false;
          "dom.security.https_only_mode_send_http_background_request" = false;
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "geo.provider.use_corelocation" = false;
          "network.auth.subresource-http-auth-allow" = 1;
          "network.captive-portal-service.enabled" = false;
          "network.connectivity-service.enabled" = false;
          "network.dns.disableIPv6" = true;
          "network.dns.disablePrefetch" = true;
          "network.http.speculative-parallel-limit" = 0;
          "network.predictor.enabled" = false;
          "network.prefetch-next" = false;
          "pdfjs.enableScripting" = false;
          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;
          "security.cert_pinning.enforcement_level" = 2;
          "security.mixed_content.block_display_content" = true;
          "security.OCSP.require" = true;
          "security.pki.crlite_mode" = 2;
          "security.pki.sha1_enforcement_level" = 1;
          "security.remote_settings.crlite_filters.enabled" = true;
          "security.ssl.require_safe_negotiation" = true;
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "security.tls.enable_0rtt_data" = false;
          "toolkit.coverage.endpoint.base" = "";
          "toolkit.coverage.opt-out" = true;
          "toolkit.telemetry.coverage.opt-out" = true;
          "privacy.resistFingerprinting" = false;
          "privacy.resistFingerprinting.block_mozAddonManager" = true;
          "privacy.resistFingerprinting.letterboxing" = true;
          "webgl.disabled" = true;
        };
      };
    };

    ghostty = {
      enable = true;

      settings = {
        mouse-hide-while-typing = true;
        unfocused-split-opacity = 0.8;

        quit-after-last-window-closed = true;
        macos-titlebar-style = "tabs";
        window-theme = "auto";
        theme = "GruvboxDark";

        cursor-style = "block";
        cursor-style-blink = false;

        macos-option-as-alt = true;
        clipboard-read = "allow";
        clipboard-paste-protection = false;
        confirm-close-surface = false;

        font-family = "Berkeley Mono";
        font-size = 13;

        window-padding-x = 4;
        window-padding-y = 4;
      };

      keybindings = {
        "super+left" = "goto_split:left";
        "super+right" = "goto_split:right";
        "super+up" = "goto_split:top";
        "super+down" = "goto_split:bottom";

        "super+control+left" = "resize_split:left,40";
        "super+control+right" = "resize_split:right,40";
        "super+control+up" = "resize_split:up,40";
        "super+control+down" = "resize_split:down,40";

        "page_up" = "scroll_page_fractional:-0.5";
        "page_down" = "scroll_page_fractional:0.5";
      };
    };
  };
}
