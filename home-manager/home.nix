{ pkgs, ... }: {
  imports = [
    ./shells.nix
    ./development.nix
    ./editors.nix
    ./apps.nix
  ];
  home = {
    username = "daniel";
    homeDirectory = "/Users/daniel";
    stateVersion = "26.05";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    sessionPath = [ "$HOME/.local/bin" ];
    packages = with pkgs; [
      fd
      jq
      ncdu
      libimobiledevice
      herdr
      hunk
      starship-jj
      fx
      uv
      codex
      cursor-cli
      pi-coding-agent
      _1password-cli
      (pkgs.callPackage ../pkgs/skl.nix { })
    ];
  };
  xdg.enable = true;
  programs.home-manager.enable = true;
  programs.man.generateCaches = false;
  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.htop.enable = true;
  programs.yazi.enable = true;
  programs.zellij = {
    enable = true;
    # Preserve the existing keymap through the module's native KDL option.
    extraConfig = builtins.readFile ./zellij.kdl;
  };
  programs.asciinema = {
    enable = true;
    settings.server.url = "https://asciinema.org/";
  };
}
