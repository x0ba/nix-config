{
  add_newline = true;
  # prompt
  format = ''
    ($username)[@](bold white)($hostname)
    ($directory)
  '';

  right_format = "$all";
  character = {
    success_symbol = "";
    error_symbol = "[](bold red)";
  };
  username = {
    disabled = false;
    show_always = true;
    style_user = "bold white";
    format = "[$user]($style)";
  };
  hostname = {
    disabled = false;
    ssh_only = false;
    style = "bold white";
    format =  "[$hostname]($style)";
  };
  directory = {
    disabled = false;
    truncation_length = 1;
    home_symbol = "~";
    format = "[$path](bold cyan)[/](bold green) ";
  };
  git_branch = {
    symbol = " ";
    style = "bold blue";
  };
  git_commit = {
    commit_hash_length = 4;
    tag_symbol = "🔖 ";
  };
  git_state = {
    format = "[\($state( $progress_current of $progress_total)\)]($style) ";
    cherry_pick = "[🍒 PICKING](bold red)";
  };
  cmd_duration.disabled = true;
}
