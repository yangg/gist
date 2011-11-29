#!/bin/bash

cd ~
kernel=`uname -s`
kernel=${kernel:0:6} # Darwin, CYGWIN_NT-6.1, Linux
if [ $kernel = Darwin ]; then
# Mac

# jsl
if [ "`which jsl`" = "" ]; then
    curl http://www.javascriptlint.com/download/jsl-0.3.0-mac.tar.gz | tar xzf -
    mv jsl-* jsl-latest
    sudo cp jsl-latest/jsl /usr/local/bin
    rm -r jsl-latest
fi

echo 'source ~/.bash_aliases' >> .bash_profile

elif [ $kernel = CYGWIN ]; then

cat > .bash_cygwin <<EOF

# require vim, git, openssh, zip/unzip, wget, curl
export PATH="/bin:${PATH}"

TT=${TT//\\\\//}   # replace backslash to fowardslash
if [[ $TT != "" ]]; then
    cd "$TT"
    if [[ $LANG != "C.UTF-8" ]]; then
        mintty &
        exit
    fi
else
    cd ~
fi

script_path=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
source $script_path/.bash_aliases
PS1=${PS1/\\u@\\h/yangg@idkin}

# vim: ft=sh
EOF


cat > .minttyrc <<EOF
Font=Consolas
FontHeight=12
CopyAsRTF=no
Locale=C
Charset=UTF-8
EOF

cat > .local.vimrc <<EOF

if has("gui_running")
    let &rtp = substitute(&rtp, 'vimfiles', '.vim', 'g')
    set guifont=Consolas:h14
endif
colorscheme eclipse
autocmd BufWritePre *.js silent!
            \ execute "'[,']s/".'\(alert\|console\.log\)([^()]\{-})\zs$/;/'
EOF

echo 'source ~/.bash_cygwin' >> .bashrc

else
# Ubuntu

# update package resource
sudo apt-get update && sudo apt-get upgrade
# install software
sudo apt-get install -y git vim-gnome ctags curl xclip
# emacs
# sudo apt-get install -y emacs23
# javascript lint for Vim
if [ "`which jsl`" = "" ]; then
    curl http://www.javascriptlint.com/download/jsl-0.3.0-src.tar.gz | tar xzf -
    mv jsl-* jsl-latest
    pushd $(pwd)
    cd jsl-latest/src
    make -f Makefile.ref all
    sudo cp Linux_All_DBG.OBJ/{jsl,jscpucfg} /usr/local/bin
    # generate default config file
    # sudo jsl -help:conf > /etc/jsl.conf
    popd
    rm -r jsl-latest
fi
# google-chrome
if [ "`which google-chrome`" = "" ]; then
    wget -c https://dl-ssl.google.com/linux/direct/google-chrome-stable_current_i386.deb
    sudo dpkg -i google-chrome-stable_current_i386.deb && rm $_
    sudo apt-get install -y -f
fi

fi
curl -Ok https://raw.github.com/yangg/home/master/.gitconfig
git clone git@github.com:yangg/home.git
# git clone git://github.com/yangg/home.git
rm .gitconfig && cd home
if [ $kernel = CYGWIN ]; then
    wget -c http://cloud.github.com/downloads/yangg/home/vim-win-patch.zip
    unzip vim-win-patch.zip && rm $_
fi
ls -A | xargs -I {} mv -v {} ../
cd ../ && rmdir home

# chnroute
# http://code.google.com/p/chnroutes/downloads/list

# ubuntu
# 1. Disable menu access keys : Terminal - Edit - Keyboard Shortcuts
# 2. Disable Keyborad Shortcuts Alt+Space
# 3. Input Methods Alt+Shift

exit 0
# vim: ft=sh