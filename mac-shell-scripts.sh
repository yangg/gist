system_profiler SPHardwareDataType
system_profiler SPHardwareDataType|grep "Processor Speed"|awk -F: '{print $2}'

# Create a RAM Disk in Mac OS X
diskutil erasevolume HFS+ "ramdisk" `hdiutil attach -nomount ram://1165430`

# show hidden files
defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder
# delete to deactivate
# Enable the iTunes song & artist Dock icon popups
defaults delete com.apple.dock itunes-notifications && killall Dock
# Enable select text in quick look window
defaults write com.apple.finder QLEnableTextSelection -bool true && killall Finder
# Enable scroll to open Dock
defaults write com.apple.dock scroll-to-open -bool true && killall Dock
# Show a full size window when scroll up in Mission Control
defaults write com.apple.dock expose-cluster-scale -float 1 && killall Dock
# Set the path bar to be relative home directory in Mac OS X Finder
defaults write com.apple.finder PathBarRootAtHome -bool true && killall Finder
# Jump to the most recently used desktop space
defaults write com.apple.dock double-tap-jump-back -bool true && killall Dock
# Change the Default File Name of Screen Shots
defaults write com.apple.screencapture name OSXDaily && killall SystemUIServer

# Hide the Spotlight Menu Icon in OS X Lion (755 to revert)
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search && killall SystemUIServer

# Splitlight
# Stopping Spotlight from Indexing External Drives
mdutil -i off /Volumes/VolumeName
# Reindexing Spotlight
sudo mdutil -E /Volumes/Macintosh\ HD/
# Individually Reindexing Selected Files
mdimport folder/or/file

# Sleep from the command line
pmset sleepnow
osascript -e 'tell application "System Events" to Sleep'

launchctl
# disable/reenable spotlight
sudo launchctl unload/load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist

# Show Download History List of All Files Ever Downloaded Within Mac OS X
sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent'
# delete
sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'

# git
# http://code.google.com/p/git-osx-installer/downloads/list
curl http://git-osx-installer.googlecode.com/files/git-1.7.7.3-intel-universal-snow-leopard.dmg -o git.dmg
# exclude multiple(1,2) columns using awk
Volume=`hdiutil attach git.dmg | tail -n 1 | awk '{$1=$2=""}1'`
Volume=`echo $Volume | sed 's/^\s*//'`
Pkg=`ls "$Volume" | grep .pkg$`
sudo installer -pkg "$Volume/$Pkg" -target /usr/local
hdiutil detach "$Volume"
