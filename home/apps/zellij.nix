{ ... }: {
  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-frappe";
      simplified_ui = true;
    };
  };
}
