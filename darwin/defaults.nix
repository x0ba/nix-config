{ config, lib, ... }: {
  system.defaults = {
    NSGlobalDomain = {
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      AppleInterfaceStyleSwitchesAutomatically = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = true;
    };
    finder = {
      FXPreferredViewStyle = "Nlsv";
    };
    dock = {
      autohide = true;
      magnification = false;
      largesize = 100;
      tilesize = 62;
      orientation = "bottom";
      show-recents = true;
      showhidden = true;
      persistent-apps = [
        "/System/Applications/Apps.app"
        "/Applications/Google Chrome.app"
        "/Applications/Grok Bot.app"
      ];
      persistent-others = [
        {
          folder = {
            path = "/Users/daniel/Downloads";
            arrangement = "date-added";
            displayas = "stack";
            showas = "fan";
          };
        }
      ];
    };
    menuExtraClock = {
      ShowAMPM = false;
      ShowDate = 0;
      ShowDayOfWeek = false;
    };
  };

  # List-view icon size is nested, and existing folders remember icon/column
  # view in .DS_Store. Patch iconSize only, then drop those overrides so
  # FXPreferredViewStyle actually applies. Desktop is left alone.
  system.activationScripts.postActivation.text = lib.mkAfter ''
    echo "applying Finder list-view defaults..." >&2
    user=${lib.escapeShellArg config.system.primaryUser}
    home=${lib.escapeShellArg config.users.users.${config.system.primaryUser}.home}

    plist_tmp=$(mktemp)
    sudo -u "$user" defaults export com.apple.finder "$plist_tmp"
    changed=0
    for key in \
      StandardViewSettings.ListViewSettings.iconSize \
      StandardViewSettings.ExtendedListViewSettingsV2.iconSize \
      FK_StandardViewSettings.ListViewSettings.iconSize \
      FK_StandardViewSettings.ExtendedListViewSettingsV2.iconSize \
      FK_DefaultListViewSettings.iconSize \
      ComputerViewSettings.ListViewSettings.iconSize \
      ComputerViewSettings.ExtendedListViewSettingsV2.iconSize \
      ICloudViewSettings.ListViewSettings.iconSize \
      ICloudViewSettings.ExtendedListViewSettingsV2.iconSize \
      TrashViewSettings.ListViewSettings.iconSize \
      TrashViewSettings.ExtendedListViewSettingsV2.iconSize
    do
      current=$(/usr/bin/plutil -extract "$key" raw -o - "$plist_tmp" 2>/dev/null || true)
      if [ -n "$current" ] && [ "$current" != "32" ] && [ "$current" != "32.0" ]; then
        /usr/bin/plutil -replace "$key" -integer 32 "$plist_tmp"
        changed=1
      fi
    done
    if [ "$changed" -eq 1 ]; then
      sudo -u "$user" defaults import com.apple.finder "$plist_tmp"
    fi
    rm -f "$plist_tmp"

    cleared=0
    if [ -f "$home/.DS_Store" ]; then
      rm -f "$home/.DS_Store"
      cleared=1
    fi
    for dir in \
      "$home/Documents" \
      "$home/Downloads" \
      "$home/Developer" \
      "$home/Pictures" \
      "$home/Movies" \
      "$home/Music" \
      "$home/Public" \
      "$home/Library/Mobile Documents/com~apple~CloudDocs"
    do
      if [ -d "$dir" ]; then
        if sudo -u "$user" find "$dir" \
          -name .git -prune -o \
          -name node_modules -prune -o \
          -name .direnv -prune -o \
          -name .DS_Store -type f -print -delete 2>/dev/null \
          | grep -q .; then
          cleared=1
        fi
      fi
    done

    saved="$home/Library/Saved Application State/com.apple.finder.savedState"
    if [ -e "$saved" ]; then
      rm -rf "$saved"
      cleared=1
    fi

    if [ "$changed" -eq 1 ] || [ "$cleared" -eq 1 ]; then
      killall Finder || true
    fi
  '';
}
