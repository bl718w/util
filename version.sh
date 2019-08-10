#!/bin/bash

branch=$(git branch | grep \* | cut -d ' ' -f2)
if [ $branch == 'develop' ]; then
   echo 'source ../environment_versions.txt'
   source ../environment_versions.txt

   echo 'git checkout develop'
   git checkout develop

   echo 'git stash'
   git stash

   echo 'git pull'
   git pull

   echo 'increment the version'
   NEW_PATCH=PROD_PATCH
   ((NEW_PATCH++))
   echo PROD_PATCH=$PROD_PATCH NEW_PATCH=$NEW_PATCH
   sed -i -e "s/PROD_PATCH=${PROD_PATCH}/PROD_PATCH=${NEW_PATCH}/g" ../environment_versions.txt
   sed -i -e "s/PROD=$PROD_MAJOR.$PROD_MINOR.$PROD_PATCH/PROD\=$PROD_MAJOR.$PROD_MINOR.$NEW_PATCH/g" ../environment_versions.txt
   source ../environment_versions.txt

   echo 'git add ../environment_versions.txt'
   git add ../environment_versions.txt

   echo 'git commit'
   git commit -m "Bumping production version to $PROD [skip ci]"

   echo 'git push'
   git push
fi
