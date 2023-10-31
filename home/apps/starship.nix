{
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_status$character ";
      add_newline = false;
      character = {
        format = "$symbol";
        success_symbol = "[λ](fg:blue)";
        error_symbol = "[λ](fg:red)";
      };
      directory.style = "fg:cyan";
    };
  };
}
