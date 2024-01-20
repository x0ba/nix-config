{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv) isLinux isDarwin;
in {
  config = lib.mkIf config.isGraphical {
    programs.firefox = {
      enable = true;
      # since I'm using firefox from brew on darwin, I need to build a dummy package
      # to still manage it via home-manager
      package =
        pkgs.lib.mkIf isDarwin (pkgs.writeScriptBin "__dummy-firefox" "");
      profiles.default = {
        search.default = "DuckDuckGo";
        search.force = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          multi-account-containers
          onepassword-password-manager
          ublock-origin
          tridactyl
        ];
        settings = {
          "app.normandy.api_url" = "";
          "app.normandy.enabled" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "app.shield.optoutstudies.enabled" = false;
          "app.update.auto" = false;
          "beacon.enabled" = false;
          "breakpad.reportURL" = "";
          "browser.aboutConfig.showWarning" = false;
          "browser.cache.offline.enable" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "browser.crashReports.unsubmittedCheck.enabled" = false;
          "browser.disableResetPrompt" = true;
          "browser.formfill.enable" = false;
          "browser.newtab.preload" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" =
            false;
          "browser.newtabpage.enabled" = false;
          "browser.newtabpage.enhanced" = false;
          "browser.newtabpage.introShown" = true;
          "browser.quitShortcut.disabled" = true;
          "browser.safebrowsing.appRepURL" = "";
          "browser.safebrowsing.blockedURIs.enabled" = false;
          "browser.safebrowsing.downloads.enabled" = false;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.downloads.remote.url" = "";
          "browser.safebrowsing.enabled" = false;
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;
          "browser.selfsupport.url" = "";
          "browser.send_pings" = false;
          "browser.sessionstore.privacy_level" = 0;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.tabs.firefox-view" = false;
          "browser.urlbar.groupLabels.enabled" = false;
          "browser.urlbar.quicksuggest.enabled" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.urlbar.trimURLs" = false;
          "browser.warnOnQuitShortcut" = false;
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "device.sensors.ambientLight.enabled" = false;
          "device.sensors.enabled" = false;
          "device.sensors.motion.enabled" = false;
          "device.sensors.orientation.enabled" = false;
          "device.sensors.proximity.enabled" = false;
          "dom.battery.enabled" = false;
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_ever_enabled" = true;
          "dom.webaudio.enabled" = false;
          "experiments.activeExperiment" = false;
          "experiments.enabled" = false;
          "experiments.manifest.uri" = "";
          "experiments.supported" = false;
          "extensions.CanvasBlocker@kkapsner.de.whiteList" = "";
          "extensions.ClearURLs@kevinr.whiteList" = "";
          "extensions.Decentraleyes@ThomasRientjes.whiteList" = "";
          "extensions.FirefoxMulti-AccountContainers@mozilla.whiteList" = "";
          "extensions.TemporaryContainers@stoically.whiteList" = "";
          "extensions.autoDisableScopes" = 14;
          "extensions.getAddons.cache.enabled" = false;
          "extensions.getAddons.showPane" = false;
          "extensions.pocket.enabled" = false;
          "extensions.shield-recipe-client.api_url" = "";
          "extensions.shield-recipe-client.enabled" = false;
          "extensions.webservice.discoverURL" = "";
          "media.autoplay.default" = 1;
          "media.autoplay.enabled" = false;
          "media.navigator.enabled" = false;
          "media.peerconnection.enabled" = false;
          "media.video_stats.enabled" = false;
          "network.IDN_show_punycode" = true;
          "network.allow-experiments" = false;
          "network.captive-portal-service.enabled" = false;
          "network.cookie.cookieBehavior" = 1;
          "network.dns.disablePrefetch" = true;
          "network.dns.disablePrefetchFromHTTPS" = true;
          "network.http.referer.spoofSource" = true;
          "network.http.speculative-parallel-limit" = 0;
          "network.predictor.enable-prefetch" = false;
          "network.predictor.enabled" = false;
          "network.prefetch-next" = false;
          "pdfjs.enableScripting" = false;
          "privacy.donottrackheader.enabled" = true;
          "privacy.donottrackheader.value" = 1;
          "privacy.query_stripping" = true;
          "privacy.trackingprotection.cryptomining.enabled" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.fingerprinting.enabled" = true;
          "privacy.trackingprotection.pbmode.enabled" = true;
          "privacy.usercontext.about_newtab_segregation.enabled" = true;
          "security.ssl.disable_session_identifiers" = true;
          "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" =
            false;
          "signon.autofillForms" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.cachedClientID" = "";
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.prompted" = 2;
          "toolkit.telemetry.rejected" = true;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.unifiedIsOptIn" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "webgl.disabled" = true;
          "webgl.renderer-string-override" = " ";
          "webgl.vendor-string-override" = " ";

          # set these to false if you're copying this config...
          # it's to *enable* DRM, not disable it
          "media.eme.enabled" = true;
          "media.gmp-widevinecdm.enabled" = true;
        };
        userChrome = ''
          /*
           *  Hide window controls
           */
          .titlebar-buttonbox-container{
              display: none !important;
          }

          .titlebar-placeholder,
          #TabsToolbar .titlebar-spacer{ display: none; }
          #navigator-toolbox::after{ display: none !important; }


          /*
           *  Hide all the clutter in the navbar
           */
          #main-window :-moz-any(#back-button,
                #forward-button,
                #stop-reload-button,
                #home-button,
                #library-button,
                #sidebar-button,
                #star-button,
                #pocket-button,
                #permissions-granted-icon,
                #fxa-toolbar-menu-button,
                #_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action, /* Vimium */
                #ublock0_raymondhill_net-browser-action) { display: none !important; }

          /*
           *  Hide tabs if only one tab
           */
          #titlebar .tabbrowser-tab[first-visible-tab="true"][last-visible-tab="true"]{
              display: none !important;
          }

          /*
           *  Minimal theme
           */
          #navigator-toolbox toolbarspring {
              display: none;
          }

          /* Hide filler */
          #customizableui-special-spring2{
              display:none;
          }

          .tab-background{
              padding-bottom: 0 !important;
          }

          #navigator-toolbox #urlbar-container {
              padding: 0 !important;
              margin: 0 !important;
          }

          #navigator-toolbox #urlbar {
              border: none !important;
              border-radius: 0 !important;
              box-shadow: none !important;
          }

          #navigator-toolbox #PanelUI-button {
              padding: 0 !important;
              margin: 0 !important;
              border: none !important;
          }

          #navigator-toolbox #nav-bar {
              box-shadow: none !important;
          }

          #navigator-toolbox #pageActionButton {
              display: none;
          }

          #navigator-toolbox #pageActionSeparator {
              display: none;
          }

          #fullscr-toggler {
              height: 0 !important;
          }

          #navigator-toolbox .urlbar-history-dropmarker {
              display: none;
          }

          #navigator-toolbox #tracking-protection-icon-container {
              padding-right: 0 !important;
              border: none !important;
              display: none !important;
          }

          #navigator-toolbox .tab-close-button, #navigator-toolbox #tabs-newtab-button {
              display: none;
          }

          #navigator-toolbox #urlbar {
              padding: 0 !important;
              padding-left: 1ch !important;
              font-size: 13px;
          }

          #navigator-toolbox #urlbar-background {
              border: none !important;
              margin: 0 !important;
          }

          #navigator-toolbox .toolbarbutton-1 {
              width: 22px;
          }

          #navigator-toolbox .tabbrowser-tab {
              font-size: 14px
          }

          #navigator-toolbox .tab-background {
              box-shadow: none!important;
              border: none !important;
          }

          #navigator-toolbox .tabbrowser-tab::after {
              display: none !important;
          }

          #navigator-toolbox #urlbar-zoom-button {
              border: none !important;
          }

          #appMenu-fxa-container, #appMenu-fxa-container + toolbarseparator {
              display: none !important;
          }

          #sync-setup {
              display: none !important;
          }

          /*
           *  Hamburger menu to the left
           */

          #PanelUI-button {
              -moz-box-ordinal-group: 0;
              border-left: none !important;
              border-right: none !important;
              position: absolute;
          }

          #toolbar-context-menu .viewCustomizeToolbar {
              display: none !important;
          }

          :root[uidensity=compact] #PanelUI-button {
              margin-top: -30px;
          }

          #PanelUI-button {
              margin-top: -30px;
          }

          :root[uidensity=touch] #PanelUI-button {
              margin-top: -36px;
          }

          /*
           *  Tabs to the right of the urlbar
           */

          /* Modify these to change relative widths or default height */
          #navigator-toolbox{
              --uc-navigationbar-width: 40vw;
              --uc-toolbar-height: 40px;
          }
          /* Override for other densities */
          :root[uidensity="compact"] #navigator-toolbox{ --uc-toolbar-height: 30px; }
          :root[uidensity="touch"] #navigator-toolbox{ --uc-toolbar-height: 40px; }

          :root[uidensity=compact] #urlbar-container.megabar{
              --urlbar-container-height: var(--uc-toolbar-height) !important;
              padding-block: 0 !important;
          }
          :root[uidensity=compact] #urlbar.megabar{
              --urlbar-toolbar-height: var(--uc-toolbar-height) !important;
          }

          /* prevent urlbar overflow on narrow windows */
          /* Dependent on how many items are in navigation toolbar ADJUST AS NEEDED */
          @media screen and (max-width: 1300px){
              #urlbar-container{ min-width:unset !important }
          }

          #TabsToolbar{ margin-left: var(--uc-navigationbar-width); }
          #tabbrowser-tabs{ --tab-min-height: var(--uc-toolbar-height) !important; }

          /* This isn't useful when tabs start in the middle of the window */
          .titlebar-placeholder[type="pre-tabs"],
          .titlebar-spacer[type="pre-tabs"]{ display: none }

          #navigator-toolbox > #nav-bar{
              margin-right:calc(100vw - var(--uc-navigationbar-width));
              margin-top: calc(0px - var(--uc-toolbar-height));
          }

          /* Zero window drag space  */
          :root[tabsintitlebar="true"] #nav-bar{ padding-left: 0px !important; padding-right: 0px !important; }

          /* 1px margin on touch density causes tabs to be too high */
          .tab-close-button{ margin-top: 0 !important }

          /* Hide dropdown placeholder */
          #urlbar-container:not(:hover) .urlbar-history-dropmarker{ margin-inline-start: -30px; }

          /* Fix customization view */
          #customization-panelWrapper > .panel-arrowbox > .panel-arrow{ margin-inline-end: initial !important; }

        '';
      };
    };

    xdg.mimeApps.defaultApplications = {
      "text/html" = "chromium.desktop";
      "x-scheme-handler/http" = "chromium.desktop";
      "x-scheme-handler/https" = "chromium.desktop";
      "x-scheme-handler/about" = "chromium.desktop";
      "x-scheme-handler/unknown" = "chromium.desktop";
    };
  };
}
