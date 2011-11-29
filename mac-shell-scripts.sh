system_profiler SPHardwareDataType
system_profiler SPHardwareDataType|grep "Processor Speed"|awk -F: '{print $2}'

# Create a RAM Disk in Mac OS X
diskutil erasevolume HFS+ "ramdisk" `hdiutil attach -nomount ram://1165430`

# show hidden files
defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder
# Enable the iTunes song & artist Dock icon popups
defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Dock
defaults delete com.apple.dock itunes-notifications && killall Dock
# Enable select text in quick look window
defaults write com.apple.finder QLEnableTextSelection -bool true && killall Finder

launchctl

# git
# http://code.google.com/p/git-osx-installer/downloads/list
curl http://git-osx-installer.googlecode.com/files/git-1.7.6-i386-snow-leopard.dmg -o git.dmg
hdiutil attach git.dmg
GIT_Volume=`ls /Volumes/ | grep Git`
GIT_pkg=`ls "/Volumes/$GIT_Volume" | grep ^git-`
sudo installer -pkg "/Volumes/$GIT_Volume/$GIT_pkg" -target /usr/local
hdiutil detach "/Volumes/$GIT_Volume"
