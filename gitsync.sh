#!/bin/bash

# setup
mkdir -p ~/tmp/
yes | cp environment_versions.txt /tmp/
gitbranch=$(git branch | grep '*' | cut -d' ' -f2)

# update master branch
git pull
git add environment_versions.txt
git commit -m 'update dev branch'
git push

# update develop branch
git checkout develop
yes | cp /tmp/environment_versions.txt .
git add environment_versions.txt
git commit -m 'update environment_versions.txt'
git push

# cleanup
yes | rm ~/tmp/environment_versions.txt
git checkout $gitbranch

