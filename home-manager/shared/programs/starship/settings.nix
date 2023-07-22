{
  scan_timeout = 10;
  # prompt
  format = "$directory $git_branch$nix_shell\n$character";
  add_newline = false;
  line_break.disabled = true;
  character = {
    success_symbol = "[](blue)";
    error_symbol = "[](red)";
  };
  # git
  git_branch = {
    style = "purple";
    symbol = "";
  };
  directory = {
    style = "bg:#262626";
    format = "[ $path ]($style)";
  };
  git_metrics = {
    disabled = false;
    added_style = "bold yellow";
    deleted_style = "bold red";
  };
  # package management
  package.format = "version [$version](bold green) ";
  nix_shell.symbol = " ";
}
