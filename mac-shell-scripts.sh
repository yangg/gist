system_profiler SPHardwareDataType
system_profiler SPHardwareDataType|grep "Processor Speed"|awk -F: '{print $2}'

# Create a RAM Disk in Mac OS X
diskutil erasevolume HFS+ "ramdisk" `hdiutil attach -nomount ram://1165430`

# show hidden files
defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder
# delete to deactivate
# Enable the iTunes song & artist Dock icon popups
defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Dock
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

# Hide the Spotlight Menu Icon in OS X Lion (755 to revert)
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search && killall SystemUIServer

# Stopping Spotlight from Indexing External Drives
mdutil -i off /Volumes/VolumeName

launchctl
# disable/reenable spotlight
sudo launchctl unload/load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist

# git
# http://code.google.com/p/git-osx-installer/downloads/list
curl http://git-osx-installer.googlecode.com/files/git-1.7.7.3-intel-universal-snow-leopard.dmg -o git.dmg
# exclude multiple(1,2) columns using awk
Volume=`hdiutil attach git.dmg | tail -n 1 | awk '{$1=$2=""}1'`
Volume=`echo $Volume | sed 's/^\s*//'`
Pkg=`ls "$Volume" | grep .pkg$`
sudo installer -pkg "$Volume/$Pkg" -target /usr/local
hdiutil detach "$Volume"
