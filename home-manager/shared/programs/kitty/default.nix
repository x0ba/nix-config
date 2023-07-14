{ config, ... }:

let theme = config.colorScheme;
in
{
  programs.kitty = {
    enable = true;
    darwinLaunchOptions = [
      "--single-instance"
    ];
    font = {
      name = "Maple Mono SC NF";
      size = 16;
    };
    settings = {
      cursor_blink_interval = 0;
      cursor_shape = "underline";
      mouse_hide_wait = 3;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      confirm_os_window_close = 0;

      scrollback_pager = "less +G +R";
      wheel_scroll_multiplier = 5;
      focus_follows_mouse = true;
      remember_window_size = true;
      initial_window_width = 900;
      initial_window_height = 600;
      repaint_delay = 10;
      input_delay = 3;
      term = "xterm-kitty";
      window_border_width = 0;
      window_padding_width = 22;
      background_opacity = 1;
      # hide_window_decorations = false;
    };
    extraConfig = ''
      hide_window_decorations titlebar-only
      foreground #dde1e6
      background #161616
      selection_foreground #f2f4f8
      selection_background #525252
    
      cursor #f2f4f8
      cursor_text_color #393939
    
      url_color #ee5396
      url_style single
    
      active_border_color #ee5396
      inactive_border_color #ff7eb6
    
      bell_border_color #ee5396
    
      wayland_titlebar_color system
      macos_titlebar_color system
    
      active_tab_foreground #161616
      active_tab_background #ee5396
      inactive_tab_foreground #dde1e6
      inactive_tab_background #393939
      tab_bar_background #161616
    
      color0 #262626
      color8 #393939
    
      color1 #ff7eb6
      color9 #ff7eb6
    
      color2  #42be65
      color10 #42be65
    
      color3  #82cfff
      color11 #82cfff
    
      color4  #33b1ff
      color12 #33b1ff
    
      color5  #ee5396
      color13 #ee5396
    
      color6  #3ddbd9
      color14 #3ddbd9
    
      color7  #dde1e6
      color15 #ffffff
    '';
  };
}
