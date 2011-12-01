# delete remote branch / remove github pages
git push origin :gh-pages

# reset commits
git reset --hard HEAD~3
# HEAD, HEAD^, and HEAD~2
# undo merge
git reset --hard origin/master

#  reverts the Makefile to two revisions back
git checkout master~2 Makefile

# Chinese filename
git config core.quotepath false

# Undo a `git push`
git push -f origin HEAD^:master


git remote add origin git@github.com:yangg/home.git
git push -u origin master

git push origin withemacs
# tracking branch
git checkout --track origin/withemacs

git submodule update --init --recursive

# force to push after remote reset
git push --force origin

# remove all deleted files from the project
git rm $(git ls-files --deleted)

# Print lines matching a pattern
git grep -w -e ${word}

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
