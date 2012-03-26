#!/bin/bash
# curl https://raw.github.com/yangg/gist/master/sys-setup.sh | bash
# git remote set-url origin git@github.com:yangg/home.git

cd ~
# echo $OSTYPE
# darwin11, linux-gnu, cygwin
if [[ "$OSTYPE" =~ ^darwin ]]; then
# Mac

# jsl
if [ "`which jsl`" = "" ]; then
    curl http://www.javascriptlint.com/download/jsl-0.3.0-mac.tar.gz | tar xzf -
    mv jsl-* jsl-latest
    sudo cp jsl-latest/jsl /usr/local/bin
    rm -r jsl-latest
fi

echo 'source ~/.bash_aliases' >> .bash_profile

elif [ "$OSTYPE" = cygwin ]; then

# require vim, git, openssh, zip/unzip, wget, curl

cat > .minttyrc <<EOF
Font=Consolas
FontHeight=12
Locale=C
Charset=UTF-8
EOF

cat > .local.vimrc <<EOF

set guifont=Consolas:h14
colorscheme eclipse
EOF

echo 'source ~/.bash_aliases' >> .bashrc

else
# Ubuntu

# update package resource
sudo apt-get update && sudo apt-get upgrade
# install software
sudo apt-get install -y git vim-gnome ctags curl xclip most
sudo update-alternatives --set pager /usr/bin/most

# ext
# sudo apt-get install -y emacs23 emacs23-el
# sudo apt-get install -y gimp gimp-help-en gpick gwenview tomboy

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
git clone git://github.com/yangg/home.git
if [ "$?" -eq 0 ]; then
    # backup before overwrite, no -b for mv in osx
    for file in $(ls -A home); do
        msg=$([ -e "$file" ] && mv "$file"{,~} && echo " (backup: \`$file~')")
        echo "$(mv -v "home/$file" .)$msg"
    done
    rmdir home
    # ls -A home | xargs -I {} mv -v home/{} . && rmdir home
    # mv -v home/{*,.??*} ./ && rmdir home
    if [ "$OSTYPE" = cygwin ]; then
        wget -c http://file.uedsky.com/vim-win-patch.zip
        unzip vim-win-patch.zip && rm $_
    fi
    echo 'Setup complete!'
else
    echo 'Cannot clone git files.'
fi

# chnroute
# http://code.google.com/p/chnroutes/downloads/list

# ubuntu
# 1. Disable menu access keys : Terminal - Edit - Keyboard Shortcuts
# 2. Disable Keyborad Shortcuts Alt+Space
# 3. Input Methods Alt+Shift

# uninstall
# cd && [ "`git status -s`" = "" ] && git ls | xargs -I {} rm -r {} && rm -rf .git

exit 0
# vim: ft=sh
