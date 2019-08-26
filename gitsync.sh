#!/bin/bash

# function where $1:branch, $2:files
update_branch() {
  git pull
  git add $2
  git commit -m "update version control for branch $1" 
  git push
}

# update current branch
gitbranch=$(git branch | grep '*' | cut -d' ' -f2)
file=environment_versions.txt
update_branch $gitbranch $file

# sync remain branch
mkdir -p ~/tmp/
yes | cp environment_versions.txt ~/tmp/
for branch in dev qa uat master; do
   if [[ "$branch" = "$gitbranch" ]]; then
      echo "The $branch is already updated."
   else
      git checkout $branch
      yes | cp ~/tmp/environment_versions.txt .
      update_branch $gitbranch $file
   fi
done

# cleanup
git checkout $gitbranch
yes | rm ~/tmp/environment_versions.txt

