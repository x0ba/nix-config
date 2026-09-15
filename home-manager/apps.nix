{ pkgs, ... }:
let
  json = pkgs.formats.json { };
  toml = pkgs.formats.toml { };
in
{
  programs.opencode = {
    enable = true;
    settings.autoupdate = false;
    tui = {
      theme = "one-dark";
      plugin = [ "./herdr-tui-session.js" ];
    };
  };
  xdg.configFile."opencode/herdr-tui-session.js".source = ./opencode/herdr-tui-session.js;
  xdg.configFile."opencode/plugins/herdr-agent-state.js".source =
    ./opencode/plugins/herdr-agent-state.js;
  programs.ghostty = {
    enable = true;
    package = null; # Native macOS application is installed by the cask.
    settings = {
      shell-integration-features = true;
      theme = "Vesper";
      auto-update = "off";
    };
  };
  programs.zed-editor = {
    enable = true;
    package = null;
    userSettings = {
      vim_mode = false;
      agent_servers = {
        codex-acp.type = "registry";
        cursor.type = "registry";
      };
      icon_theme = {
        mode = "system";
        light = "Zed (Default)";
        dark = "Zed (Default)";
      };
      ui_font_size = 16;
      buffer_font_size = 15;
      theme = {
        mode = "system";
        light = "Ayu Light";
        dark = "Ayu Dark";
      };
      auto_update = false;
    };
  };
  # These applications do not have suitable Home Manager settings modules.
  xdg.configFile."herdr/config.toml".source = toml.generate "herdr-config" {
    onboarding = false;
    theme = {
      name = "vesper";
      auto_switch = false;
    };
    ui.sidebar.spaces.rows = [
      [
        "state_icon"
        "workspace"
      ]
      [
        "branch"
        "git_status"
      ]
      [
        "$jj_bookmark"
        "$jj_status"
      ]
    ];
  };
  xdg.configFile."karabiner/karabiner.json".source = json.generate "karabiner-config" {
    profiles = [
      {
        name = "Default profile";
        selected = true;
        virtual_hid_keyboard.keyboard_type_v2 = "ansi";
        devices = [
          {
            identifiers = {
              is_keyboard = true;
              is_pointing_device = true;
              product_id = 3088;
              vendor_id = 13364;
            };
            ignore = false;
            ignore_vendor_events = true;
            simple_modifications = [
              {
                from.key_code = "f22";
                to = [ { apple_vendor_top_case_key_code = "keyboard_fn"; } ];
              }
            ];
          }
        ];
      }
    ];
  };
  programs.cursor = {
    enable = true;
    package = null;
    mutableExtensionsDir = false;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      userSettings = {
        "window.autoDetectColorScheme" = true;
        "cursor.composer.queueMessageDefaultBehavior" = "steer";
        "editor.accessibilitySupport" = "off";
        "cursor.cpp.disabledLanguages" = [ "plaintext" ];
      };
      extensions =
        (with pkgs.vscode-extensions; [
          astro-build.astro-vscode
          esbenp.prettier-vscode
        ])
        ++ (pkgs.callPackage ../pkgs/cursor-extensions.nix { });
    };
  };
}
