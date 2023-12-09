{lib, ...}: {
  programs.starship = {
    enable = true;
    enableTransience = true;
    enableFishIntegration = false;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$directory"
        "$character"
      ];
      right_format = "$all";
      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };
    };
  };
}
