{ config
, lib
, pkgs
, ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in
{
  programs.mpv.enable = isLinux;
  xdg.mimeApps.defaultApplications = {
    "video/mp4" = "mpv.desktop";
    "video/webm" = "mpv.desktop";
  };
  programs.zathura.enable = true;
  xdg.mimeApps.defaultApplications."application/pdf" = "zathura.desktop";

  programs.ncmpcpp = {
    enable = true;
    settings = {
      mpd_crossfade_time = 2;
      cyclic_scrolling = "yes";
      mouse_support = "yes";
      mouse_list_scroll_whole_page = "yes";
      lines_scrolled = "1";
      message_delay_time = "1";
      playlist_shorten_total_times = "yes";
      playlist_display_mode = "columns";
      browser_display_mode = "columns";
      search_engine_display_mode = "columns";
      playlist_editor_display_mode = "columns";
      autocenter_mode = "yes";
      centered_cursor = "yes";
      user_interface = "classic";
      follow_now_playing_lyrics = "yes";
      locked_screen_width_part = "50";
      ask_for_locked_screen_width_part = "yes";
      display_bitrate = "no";
      external_editor = "nvim";
      main_window_color = "default";
      startup_screen = "playlist";
      allow_for_physical_item_deletion = "yes";
      progressbar_look = "▃▃▃";
      progressbar_elapsed_color = 5;
      progressbar_color = "black";
      header_visibility = "no";
      statusbar_visibility = "yes";
      titles_visibility = "no";
      enable_window_title = "yes";
      statusbar_color = "white";
      color1 = "white";
      color2 = "blue";
      now_playing_prefix = "$b$2$7 ";
      now_playing_suffix = "  $/b$8";
      current_item_prefix = "$b$7$/b$3 ";
      current_item_suffix = "  $8";
      song_columns_list_format = "(50)[]{t|fr:Title} (0)[magenta]{a}";
      song_list_format = " {%t $R   $8%a$8}|{%f $R   $8%l$8} $8";
      song_status_format = "$b$6 $7[$8     $7]$6 $2$7{$8 %b }|{$8 %t }|{$8 %f }$7 $8";
      song_window_title_format = "Now Playing ..";
    };
    bindings = [
      {
        key = "j";
        command = "scroll_down";
      }
      {
        key = "k";
        command = "scroll_up";
      }
      {
        key = "l";
        command = "enter_directory";
      }
      {
        key = "l";
        command = "play_item";
      }
      {
        key = "h";
        command = "jump_to_parent_directory";
      }
    ];
  };

  services = {
    mpd.enable = isLinux;
    mpdris2 = {
      enable = isLinux;
      multimediaKeys = true;
      notifications = true;
    };
    mpd-discord-rpc = {
      enable = isLinux;
      settings = {
        format = {
          state = "$artist";
          large_image = "https://cdn.discordapp.com/emojis/743725086262951957.gif";
          large_text = "$album";
          small_image = "https://cdn.discordapp.com/emojis/743723149455261717.png";
          small_text = "pretty fucking based";
        };
      };
    };
    mpd-mpris.enable = isLinux;
  };

  launchd.agents.mpd = {
    enable = true;
    config =
      let
        mpdConf = pkgs.writeText "mpd.conf" (
          let
            baseDir = config.xdg.dataHome + "/mpd";
          in
          ''
            music_directory     "${config.home.homeDirectory}/Music"
            playlist_directory  "${baseDir}/playlists"
            db_file             "${baseDir}/database"
            pid_file            "${baseDir}/mpd.pid"
            state_file          "${baseDir}/state"
            log_file            "${baseDir}/log"
            auto_update "yes"
            port                "6600"
            bind_to_address     "127.0.0.1"
            audio_output {
              type "osx"
              name "CoreAudio"
              mixer_type "software"
            }
          ''
        );
      in
      {
        ProgramArguments = [ "${pkgs.mpd}/bin/mpd" "--no-daemon" "${mpdConf}" ];
        KeepAlive = true;
        RunAtLoad = true;
        ProcessType = "Interactive";
        StandardErrorPath = "${config.xdg.cacheHome}/mpd.log";
        StandardOutPath = "${config.xdg.cacheHome}/mpd.log";
      };
  };
}
