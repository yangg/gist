git add | branch | checkout | clone | commit | diff | fetch | grep | init
    | log | merge | mv | pull | push | rebase | reset | rm | show | status | tag
    | clean | revert | whatchanged | config | stash | archive | remote | submodule
    | reflog | bisect | blame
    | ls-files | filter-branch | cherry-pick | rev-parse | ls-tree | format-patch
# More: http://searchco.de/lists/list-of-git-commands

#
git config --list --show-origin

# reset commits
git reset --hard HEAD~3
# HEAD, HEAD^, and HEAD~2
# undo merge
git reset --hard origin/master
git reset --hard ORIG_HEAD

#  reverts the Makefile to two revisions back
git checkout master~2 Makefile
#
git checkout --ours path/to/file
git checkout --theris path/to/file

# Chinese filename
alias ls='ls --show-control-chars'
git config core.quotepath false

git remote add origin git@github.com:yangg/home.git
git push -u origin master

# tracking branch
git checkout --track origin/withemacs

git clone --recursive
git submodule update --init --recursive
git pull --recurse-submodules

gitk
git mergetool
git instaweb --httpd=webrick

# revision
HEAD        usually points to the currently checked out branch.
ORIG_HEAD   is previous state of HEAD

# rev-parse
git rev-parse --show-toplevel / --is-inside-work-tree

# push
git push REMOTENAME BRANCHNAME
git push REMOTENAME LOCALBRANCHNAME:REMOTEBRANCHNAME
# Deleting a remote branch or tag(remove github pages)
git push origin :gh-pages   # telling git “push nothing into BRANCHNAME on REMOTENAME”.
git branch -d -r <remote-branch>
# push specific commit
git push origin <commit sha>:master
# Undo a `git push`
git push -f origin HEAD^:master

# remove all deleted files from the project
git rm $(git ls-files --deleted)

# git tags
git tag -a/s v1.0 -m 'tag message' [{revision}]
git push --tags

# Remove a specific revision
git rebase -i <after-this-commit>
git rebase --onto master~3 master~2 master
# Before:
1---2---3---4---5  master
# After:
1---2---4'---5' master

# package
git archive -o package.zip/tar HEAD
git archive --format=tar [--prefix=folder/] HEAD | gzip > package.tar.gz

# Print lines matching a pattern
git grep -w -e ${word}

# create & apply patch http://ariejan.net/2009/10/26/how-to-create-and-apply-a-patch-with-git/
git format-patch HEAD^..HEAD --stdout > some.patch
git am --signoff < some.patch
git diff [--cached] > diff.patch
git apply --stat  diff.patch
git apply --check diff.patch

git log --follow <path/to/renamed/file>
git log --name-only
git log --name-status
git log --stat
git whatchanged

git log -g
git log --author=yangg --since="2011/8/3 00:00" --reverse --pretty=%s

log2 = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
log-timeline = log --format='%h %an %ar - %s'
log-local = log --oneline origin..HEAD
log-graph = log --all --graph --decorate
log-refs = log --all --graph --decorate --oneline --simplify-by-decoration --no-merges
log-fetched = log --oneline HEAD..origin/master

fix = commit --amend -C HEAD
eg:
git fix FILE1 FILE2     # Add changes to FILE1 and FILE2 to top commit
git fix -a              # Add all changes in working copy to top commit

wip = !"git add -A; git ls-files --deleted -z | xargs -0 git rm; git commit -m \"wip\""
unwip = !"git log -n 1 | grep -q -c wip && git reset HEAD~1"
# The wip allows for a quick way to add all new and modified files to the index, while cleaning the index from the files removed from the working tree.
# The unwip will restore the deleted files to the working tree!

# filter-branch
# Remove sensitive data http://help.github.com/remove-sensitive-data/
git filter-branch --index-filter 'git rm --cached --ignore-unmatch path/to/file' --prune-empty -- --all
# Split a subpath into a new branch or repo
git filter-branch --prune-empty --subdirectory-filter lib master
# Creating a Branch from a Stash
git stash branch branchfromstash
# change author
git filter-branch --env-filter '
if [ "$GIT_COMMITTER_EMAIL" = "old@gmail.com" ]; then
    GIT_COMMITTER_EMAIL="new@gmail.com"
fi
'
# GIT_AUTHOR_NAME
# GIT_AUTHOR_EMAIL
# GIT_COMMITTER_NAME
# GIT_COMMITTER_EMAIL
git ci --amend --reset-author

# remote
git remote add | rename | rm | set-url

# Github Secrets https://github.com/blog/967-github-secrets
# whitespace ?w=1
# cross-repository issue references user/repository#issuenumber
# .diff or .patch Add at the end fo the URL for a commit page, Pull Requrest or Compare View
# t     Actives the file finder
# l     Jump to line
# w     Switch branch/tag
