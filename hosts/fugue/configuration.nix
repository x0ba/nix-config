{
  pkgs,
  modulesPath,
  ...
}: {
  imports = ["${modulesPath}/profiles/minimal.nix"];

  wsl = {
    enable = true;
    defaultUser = "zero";
    startMenuLaunchers = true;
    wslConf.automount.root = "/mnt";
  };

  hardware.opengl.enable = true;

  environment.systemPackages = with pkgs; [
    git
    home-manager
  ];

  users.users.zero = {
    isNormalUser = true;
    home = "/home/zero";
    shell = pkgs.zsh;
    extraGroups = ["wheel"];
  };

  programs.zsh.enable = true;
}
