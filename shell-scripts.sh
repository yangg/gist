# Show the Nth line of file
sed -n 5p file
# show a range lines of a file
sed '6,14!d' file
sed -n '6,14p' file
# remove a range of lines from a file
sed '3,7d' -i file
vi +'3,7d' +x file
vi +{end..start} +x file
# *delete a particular line by line number in file
sed 5d -i file
vi +5d +x file
# *delete all leading and trailing whitespace from each line in file
sed 's/^\s*//;s/\s*$//' -i file
# *remove comment from files
sed -e '/^#/d' -e 's/#.*$//' -i file
# *delete last line of a file if it is blank
sed '${/^$/d}' -i file

# Convert HH:MM:SS into seconds
echo 00:29:36 | awk -F: '{print ($1*3600)+($2*60)+$3}'
echo 00:29:36 | sed s/:/*60+/g | bc
# Print all lines between two line numbers
awk 'NR >= 3 && NR <= 8' /path/to/file
# Rank top 10 most frequently used commands
history | awk '{if ($2 == "sudo") a[$3]++; else a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
history | cut -c8- | sort | uniq -c | sort -rn | head

lsof
# A Unix Utility You Should Know About: lsof@evernote

uptime # http://www.ruanyifeng.com/blog/2011/07/linux_load_average_explained.html
fc
Ctrl-Z / bg / jobs / fg
last reboot
whois uedsky.com
ps -ef
killall [processname]
kill -9 [pid]
xkill

# Multiple variable assignments from command output in BASH
read day month year <<< $(date +'%d %m %y')

# Jump up to any directory above the current one
upto() { cd "${PWD/\/$@\/*//$@}"; }

# Expand shortened URLs: show what site a shortened URL is pointing to, even if there are many nested shortened URLs
expandurl() { curl -sIL $1 | grep ^Location | cut -c11-; }

# Extract extention of a file
filext() { echo ${1##*.}; }

# List only the directories
ls -Al | grep ^d
ls -d */                        # not including hidden items
find . -maxdepth 1 -type d | sort               # ! -name "."

# Move all files in subdirectories to current dir
find . -type f -exec mv {} . \;

# print multiplication formulas
seq 9 | sed 'H;g' | awk -v RS='' '{for(i=1;i<=NF;i++)printf("%dx%d=%d%s", i, NR, i*NR, i==NR?"\n":"\t")}'

# Rename all (jpg) files written as 3 number in 4 numbers.
for i in ???.jpg; do mv $i $(printf %04d $(basename $i .jpg) ).jpg ; done
# Change file extensions
rename 's/\.md$/.mkd/' *.md

# Get your public ip address
curl ifconfig.me
# or
dig +short myip.opendns.com @resolver1.opendns.com

# Your GeoIP location on Google Maps
curl -s http://geoiplookup.wikimedia.org/|awk -F, '{print $3,$4}'|awk -F'"' '{print "http://maps.google.com/maps?q="$4 "," $8}'

# List your MACs address
ifconfig eth0 | grep -oE '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'

#
du -h -d 1
du -h --max-depth=1 | sort -rh
du --max-depth=1 | sort -nr | awk '{suffs="k M G"; N=split(suffs,suff," "); for(n=1; $1>1024 && n<N; n=n+1) {$1=$1/1024} printf("%0.1f%s\t%s\n", $1, suff[n], $2)}'

# copy to clipboard
cat .ssh/id_rsa.pub | pbcopy
xclip -sel clip < ~/.ssh/id_rsa.pub
xclip < ~/.ssh/id_rsa.pub

# ascii digital click(@require sysvbanner)
watch -tn1 'date +%T | xargs banner'

# prettier "cal" command
cal | grep -A7 -B7 --color=auto "\b`date +%-d`\b"
# -B, --before-context=NUM
# -A, --after-context=NUM

if [ $[ `date +%s`-`stat --printf=%Y .filenametags` ] -gt $((24*60*60)) ]; then
    echo 'do something if the file not modified in a day.'
fi

# convert from hexadecimal or octal to decimal
echo $((0x2E)) $((011))
hexdec() { bc <<< "obase=10; ibase=16; $1"; }

# convert from decimal to hexadecimal
hex() { bc <<< "obase=16; $1"; }
hex() { printf "%X\n" $1; }

# escape UTF-8 characters into their 3-byte format
escape() {
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
    echo # newline
}

# sha1 & md5
openssl sha1/md5 file
shasum/md5 file

# Create ISO images from the Command Line @ http://git.to/iso
# create an ISO with hdiutil
hdiutil makehybrid -iso -joliet -o images.iso /path/to/source
# making an ISO with dd
# Use the `diskutil list' command to discover the disks identifier that you will need to make an ISO with dd from.
dd if=/dev/disk1 of=/destination/path/image.iso
# burn an ISO with dd
dd if=/path/to/image.iso of=/dev/disk1
# convert a DMG file to ISO
hdiutil convert /path/imagefile.dmg -format UDTO -o /path/convertedimage.iso
# convert a ISO file to DMG format
hdiutil convert /path/imagefile.iso -format UDRW -o /path/convertediamge.dmg

# grep tab
grep $'\t' file.txt

# Get Gateway http://chnroutes.googlecode.com/files/chnroutes.py
# linux
ip route show | grep ^default | sed -e 's/default via \([^ ]*\).*/\1/'
# mac
netstat -nr | grep ^default | grep -v 'ppp' | awk '{print $2}'
# win
@echo off
for /F "tokens=3" %%* in ('route print ^| findstr "\<0.0.0.0\>"') do set "gw=%%*"

# named parameters in bash
myfunc() {
    local $*;
    echo "name=$name, pwd=$pwd";
}

# How to find non-ASCII characters in a file
grep --color=auto -Pn "[\x80-\xFF]"

# Find biggest 10 files
find . -type f -print0 | xargs -0 du -h | sort -hr | head

# Delete file via inode number
ls -i
find . -inum xxxx -exec rm -rf {} \;

# set ff=unix & retab
find . -type f -regex '.*\.\(php\|js\|css\)' -exec vim --noplugin +'set ff=unix' +'set fenc=utf-8' +'%retab!' +x {} \;

# Convert text to lower or upper case
tr '[:upper:]' '[:lower:]'
awk '{print tolower($0)}'
# not mac
upper() { echo ${@^^}; }
lower() { echo ${@,,}; }

# Selecting a random file/folder of a folder
ls -1 | shuf -n 1

# Set primary monitor
xrandr --output VGA-0 --primary

# rand
tr -dc "A-Z2-9" < /dev/urandom | head -c 16 | xargs

# disk w/r speed (oflag=dsync)
dd if=/dev/zero of=tmp.img bs=1M count=1024 conv=fdatasync
dd if=tmp.img of=/dev/null bs=1M

#
watch dig v2ex.com


# mac
# open Finder in terminal
open .

# Flush Directory Service cache
dscacheutil -flushcache
