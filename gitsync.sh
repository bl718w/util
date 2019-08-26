#!/bin/bash

git pull
git add environment_versions.txt
git commit -m 'update dev branch'
git push origin
