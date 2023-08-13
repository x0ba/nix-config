{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in {
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
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "Visualizer";
      lyrics_directory = "${config.xdg.dataHome}/ncmpcpp";
      visualizer_in_stereo = true;
      visualizer_type = "ellipse";
      visualizer_look = "●●";
      visualizer_color = "magenta, blue, cyan, green";
      external_editor = "nvim";
      message_delay_time = 1;
      playlist_disable_highlight_delay = 2;
      autocenter_mode = true;
      centered_cursor = true;
      ignore_leading_the = true;
      allow_for_physical_item_deletion = "no";
      lines_scrolled = "1";
      colors_enabled = true;
      playlist_display_mode = "classic";
      user_interface = "classic";
      volume_color = "white";
      song_window_title_format = "Music";
      statusbar_visibility = "no";
      header_visibility = "no";
      titles_visibility = "no";
      progressbar_look = "━━━";
      progressbar_color = "black";
      progressbar_elapsed_color = "yellow";
      song_status_format = "$7%t";
      song_list_format = "$(008)%t$R  $(247)%a$R$5  %l$8";
      song_columns_list_format = "(53)[blue]{tr} (45)[blue]{a}";
      current_item_prefix = "$b$2| ";
      current_item_suffix = "$/b$5";
      now_playing_prefix = "$b$5| ";
      now_playing_suffix = "$/b$5";
      song_library_format = "{{%a - %t} (%b)}|{%f}";
      main_window_color = "blue";
      current_item_inactive_column_prefix = "$b$5";
      current_item_inactive_column_suffix = "$/b$5";
      color1 = "white";
      color2 = "blue";
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
    config = let
      mpdConf = pkgs.writeText "mpd.conf" (
        let
          baseDir = config.xdg.dataHome + "/mpd";
        in ''
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
    in {
      ProgramArguments = ["${pkgs.mpd}/bin/mpd" "--no-daemon" "${mpdConf}"];
      KeepAlive = true;
      RunAtLoad = true;
      StandardErrorPath = "${config.xdg.cacheHome}/mpd.log";
      StandardOutPath = "${config.xdg.cacheHome}/mpd.log";
    };
  };
}
