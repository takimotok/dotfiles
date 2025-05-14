#!/bin/bash

# cf.) [macOS defaults list](https://macos-defaults.com/)

set -Ceu

(
  main() {
    # check if the os is macOS
    # _is_macos
    # _exit_with_errors "$?"

    # base
    # -----
    # disable auto-capitalization
    defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

    # distable spell correction
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool "false"

    # show files with all extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    # enable full keyboard access for all controls
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

    # set key repeat speed
    defaults write NSGlobalDomain KeyRepeat -int 2

    # set key repeat recognition time
    defaults write NSGlobalDomain InitialKeyRepeat -int 12

    # use Fn keys as standard function keys
    defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

    # system sound volume
    # -----
    # turn on
    # sudo nvram StartupMute=%00
    # sudo nvram SystemAudioVolume=%30

    # turn off
    sudo nvram StartupMute=%01
    sudo nvram SystemAudioVolume=%30

    # Dock
    # -----
    # arrange dock to right
    defaults write com.apple.dock orientation right

    # enable auto hide
    defaults write com.apple.dock "autohide" -bool true

    # delete all apps. from dock
    defaults write com.apple.dock persistent-apps -array

    # hide apps. which are recently used
    defaults write com.apple.dock "show-recents" -bool "false"

    # disable animation at launching
    defaults write com.apple.dock launchanim -bool false

    # set animation at storing
    defaults write com.apple.dock "mineffect" -string "scale"

    # disable desktop sort arrangement by its usage
    defaults write com.apple.dock "mru-spaces" -bool "false"

    # disable waiting time before it is displayed
    defaults write com.apple.dock autohide-delay -float 0

    # set the icon size of Dock items in pixels
    defaults write com.apple.dock "tilesize" -int "36"

    # Finder
    # -----
    # disable animation
    defaults write com.apple.finder DisableAllAnimations -bool true

    # show hidden files by default
    defaults write com.apple.finder AppleShowAllFiles -bool true

    # show files with all extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    # show status bar
    defaults write com.apple.finder ShowStatusBar -bool true

    # show path bar
    defaults write com.apple.finder ShowPathbar -bool true

    # show quit option. enable the `Command + q` to close Finder
    defaults write com.apple.finder QuitMenuItem -bool true

    # set default view style as list view
    defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv" && killall Finder

    # disable warning to empty trash
    defaults write com.apple.finder WarnOnEmptyTrash -bool "false"

    # show icons on Desktop. e.g.) hard drives, servers and removable medias
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

    # SystemUIServer
    # -----
    # Display date, day, and time in the menu bar
    defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM HH:mm'

    # Display battery level in the menu bar
    defaults write com.apple.menuextra.battery ShowPercent -string "YES"

    # Menu bar
    # -----
    defaults -currentHost write -globalDomain NSStatusItemSpacing -int 6
    defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 6

    # Terminal
    # -----
    # use only utf-8
    defaults write com.apple.terminal StringEncodings -array 4

    # Screenshot
    # -----
    # disable shadows
    defaults write com.apple.screencapture "disable-shadow" -bool "true"

    # set images save path
    defaults write com.apple.screencapture "location" -string "${HOME}/Desktop"

    # set default extension as .png
    defaults write com.apple.screencapture "type" -string "png"

    # Feedback
    # -----
    # disable sending feedbacks
    defaults write com.apple.appleseed.FeedbackAssistant "Autogather" -bool "false"

    # disable sending crash reports
    defaults write com.apple.CrashReporter DialogType -string "none"

    # .DS_Store
    # -----
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool "true"
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool "true"

    # Battery
    # -----
    # show battery percentage
    defaults write com.apple.menuextra.battery ShowPercent -string "YES"

    # Trackpad
    # -----
    # disable single-tap as double-tap
    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool "false"
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool "false"
    defaults -currentHost write -g com.apple.mouse.tapBehavior -bool "false"

    # enable dragging without drag lock
    #
    # Thanks to this setting, we can select a word by double tapping in a web browswer.
    #
    # Note: seems not working the settings below in macOS 14.6.1 Sonoma.
    #       So we have to set it manually like this:
    #
    #       `Accessibility > Pointer Control > Trackpad Options` then:
    #       - turn on `Use trackpad for dragging`
    #       - select `Without Drag Lock`
    #
    # defaults write com.apple.AppleMultitouchTrackpad "Dragging" -bool "true"
    # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "Dragging" -bool "true"

    # set trackpad speed
    defaults write -g com.apple.trackpad.scaling -float 12.0

    # set scrolling direction
    defaults write -g com.apple.swipescrolldirection -bool "false"

    # increase trackpad scrolling speed (higher values = faster scrolling)
    defaults write -g com.apple.trackpad.scrolling -float 12.0

    # Mouse
    # -----
    # set mouse speed
    defaults write NSGlobalDomain com.apple.mouse.scaling -float 12.0

    # set scrolling speed
    defaults write -g com.apple.scrollwheel.scaling 6

    # Others
    # -----
    # use Google's public DNS
    # networksetup -setdnsservers Wi-Fi 2001:4860:4860::8844 2001:4860:4860::8888 8.8.4.4 8.8.8.8

    # reflect settings
    # -----
    settings=("Dock" "Finder" "SystemUIServer")
    for setting in "${settings[@]}"; do
      killall "${setting}" &>/dev/null
    done
  }

  main
)
