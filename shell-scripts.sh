# Show the Nth line of file
sed -n 5p ubuntu-setup.sh
# *delete a particular line by line number in file
sed -i 5d ubuntu-setup.sh
# show a range lines of a file
sed '6,14!d' ubuntu-setup.sh
sed -n '6,14p' ubuntu-setup.sh
# delete all leading and trailing whitespace from each line in file
sed 's/^\s*//;s/\s*$//' -i file

# Convert HH:MM:SS into seconds
echo 00:29:36 | awk -F: '{print ($1*3600)+($2*60)+$3}'

lsof
# A Unix Utility You Should Know About: lsof@evernote

uptime # http://www.ruanyifeng.com/blog/2011/07/linux_load_average_explained.html
whois uedsky.com

# Multiple variable assignments from command output in BASH
read day month year <<< $(date +'%d %m %y')

# Jump up to any directory above the current one
upto() { cd "${PWD/\/$@\/*//$@}"; }

# Expand shortened URLs: show what site a shortened URL is pointing to, even if there are many nested shortened URLs
expandurl() { curl -sIL $1 | grep ^Location; }

# Extract extention of a file
filext() { echo ${1##*.}; }

# List only the directories
ls -d */
find . -type d -maxdepth 1 | sort
ls -l | grep ^d

# Move all files in subdirectories to current dir
find . -type f -exec mv {} . \;

＃ print multiplication formulas
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

#
du -h -d 1
du -h --max-depth=1 | sort -rh
du --max-depth=1 | sort -nr | awk '{suffs="k M G"; N=split(suffs,suff," "); for(n=1; $1>1024 && n<N; n=n+1) {$1=$1/1024} printf("%0.1f%s\t%s\n", $1, suff[n], $2)}'

# copy to clipboard
cat .ssh/id_rsa.pub | pbcopy
xclip -sel clip < ~/.ssh/id_rsa.pub


# not mac
# Convert text to lower or upper case
upper() { echo ${@^^}; }
lower() { echo ${@,,}; }

# Selecting a random file/folder of a folder
ls -1 | shuf -n 1


# mac
# open Finder in terminal
open .

# Flush Directory Service cache
dscacheutil -flushcache