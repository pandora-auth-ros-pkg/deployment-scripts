#!/bin/bash

DIRS=$(find $1 -maxdepth 1 -mindepth 1 -type d -not -name .git)

CURR=$PWD

default[0]='hydro-devel'
default[1]='master'
changes[0]=' '
changes[1]='*'

for repo in $DIRS; do
  cd $repo;
  branch=$(git rev-parse --abbrev-ref HEAD);
  git diff-index --quiet HEAD;
  diff=$?;
  if [ $branch == ${default[0]} ] || [ $branch == ${default[1]} ]
    then
      echo -e '\033[1;32m'${changes[$diff]}" "'\033[0;34m'$branch'\033[0m'" --> " '\033[0;37m'$repo ;
    else
      echo -e '\033[1;32m'${changes[$diff]}" "'\033[0;31m'$branch'\033[0m'" --> " $repo ;
  fi
  cd $CURR;
done

