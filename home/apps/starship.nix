{
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory $git_branch$git_status$nix_shell\n$character ";
      add_newline = false;
      character = {
        format = "$symbol";
        success_symbol = "[](fg:blue)";
        error_symbol = "[](fg:red)";
      };
      directory = {
        format = "[ $path ](bg:black)";
      };
    };
  };
}
