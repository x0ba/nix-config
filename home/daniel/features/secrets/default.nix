{config, ...}: {
  sops = {
    gnupg.home = config.programs.gpg.homedir;
    defaultSopsFile = ./main.yaml;
    secrets = {
      "wakatime-cfg".path = "${config.xdg.configHome}/wakatime/.wakatime.cfg";
      "ssh-cfg".path = "${config.home.homeDirectory}/.ssh/config";
    };
  };
}
