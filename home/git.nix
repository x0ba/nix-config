{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Daniel Xu";
        email = "hi@danielx.me";
      };
      init.defaultBranch = "main";
      branch.autosetuprebase = "always";
      push.autoSetupRemote = true;
      color.ui = true;
      alias = {
        prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
        root = "rev-parse --show-toplevel";
        cleanup = "!git branch --merged | grep -v '\\*\\|master\\|main\\|develop' | xargs -n 1 -r git branch -d";
      };
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
      prompt = "enabled";
      aliases.co = "pr checkout";
    };
  };
}
