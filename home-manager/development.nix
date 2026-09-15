{
  lib,
  pkgs,
  ...
}:
{
  programs.git = {
    enable = true;
    ignores = [ ".direnv/" ];
    settings.user = {
      name = "Daniel Xu";
      email = "hi@danielx.me";
    };
    signing = {
      key = "6F5289366A8018FAFEAE1C468BE6AC395444462A";
      signByDefault = true;
    };
  };
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options.navigate = true;
  };
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Daniel Xu";
        email = "hi@danielx.me";
      };
      signing = {
        backend = "gpg";
        key = "6F5289366A8018FAFEAE1C468BE6AC395444462A";
        behavior = "own";
      };
      ui = {
        pager = "delta";
        diff-formatter = ":git";
      };
    };
  };
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
      aliases.co = "pr checkout";
    };
  };
  programs.gpg.enable = true;
  # Home Manager has no option for GnuPG common.conf.
  home.file.".gnupg/common.conf".text = "use-keyboxd\n";
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry_mac;
  };
  # GnuPG starts its agent on demand using ~/.gnupg/S.gpg-agent.
  # The upstream launchd service uses an unwritable /private/var/run socket;
  # retain the module's configuration and shell hooks with native autostart.
  launchd.agents.gpg-agent.enable = lib.mkForce false;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [ "~/.orbstack/ssh/config" ];
  };
}
