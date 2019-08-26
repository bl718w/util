#!/bin/bash

if [[ ! -e environment_versions.txt ]]; then
   echo 'Failed to find environment_version.txt in the current directory.'
   exit 1
fi

gitbranch=$(git branch | grep '*' | cut -d' ' -f2)
case $gitbranch in
  dev)
     branch=DEV
     ;;
  QA)
     branch=QA
     ;;
  UAT)
     branch=UAT
     ;;
  master)
     branch=PROD
     ;;
  trunk)
     branch=QA
     ;;
  *)
     echo 'Existing branch does not match one require version control.'
     exit 1
esac

version=$(grep -i $branch environment_versions.txt | cut -d'=' -f2)
major=$(echo $version | cut -d'.' -f1)
minor=$(echo $version | cut -d'.' -f2)
patch=$(echo $version | cut -d'.' -f3)
((patch++))

sed -i "/^$branch.*$/c $branch=$major.$minor.$patch" environment_versions.txt

