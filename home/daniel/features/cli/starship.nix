{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = ''
        $directory$git_branch$node$rust
        $cmd_duration[›](bold green) [|](dimmed white) (none)
      '';
      directory = {
        home_symbol = "";
        format = "[$path]($style) ";
        truncate_to_repo = true;
      };
      time.disabled = true;
    };
  };
}
