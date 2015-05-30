#!/bin/bash

# Store command line arguments
DIRS=$(find $1 -maxdepth 1 -mindepth 1 -type d -not -name .git)
REMOTE=$2
DEFAULT_BRANCH[0]=$3
DEFAULT_BRANCH[1]=$4

# Bold color list
colors ()
{
  RESET='\e[0m'
  BLACK='\e[1;30m'
  RED='\e[1;31m'
  GREEN='\e[1;32m'
  YELLOW='\e[1;33m'
  BLUE='\e[1;34m'
  PURPLE='\e[1;35m'
  CYAN='\e[1;36m'
  WHITE='\e[1;37m'
}; colors

# Make newlines the only separator
IFS=$'\n'

# Main function
repo_reset ()
{
  local repo
  for repo in $DIRS; do
    cd ${repo// /\ }
    
    # Shorten repo directory path
    local repo_short=`echo $repo | rev | cut -d"/" -f1-1 | rev`
    echo -e "${BLUE}[${repo_short}]${RESET}"
    
    local git_exists=`ls -a | grep .git`
    if [ -z "${git_exists}" ]; then
      echo -e "${YELLOW}Not a git repository!\n${RESET}"
      continue
    fi
    
    echo -e "${WHITE}Fetching...${RESET}"
    #git fetch --quiet
    
    # Find if any of the default branches exist
    local default_branch
    local branch
    for branch in ${DEFAULT_BRANCH[*]}; do
      if [ "`git branch --list ${branch}`" ]; then
        default_branch=$branch
        break
      fi
    done
    
    if [ -z "${default_branch}" ]; then
      echo -e "${YELLOW}A default branch does not exist!\n${RESET}"
      continue
    fi
    
    git diff-index --quiet HEAD
    local diff=$?
    if [ $diff == 1 ]; then
      #git stash --quiet
      echo -e "${RED}Stashed changes${RESET}"
    fi
    
    local curr_branch=`git rev-parse --abbrev-ref HEAD`
    if [ $curr_branch != $default_branch ]; then
      #git checkout ${default_branch} --quiet
      echo -e "${GREEN}Checked out to ${default_branch}${RESET}"
    fi

    local local_sha=`git rev-parse ${default_branch}`
    local remote_sha=`git rev-parse ${REMOTE}/${default_branch}`
    if [ $local_sha != $remote_sha ]; then
      #git reset --hard ${REMOTE}/${default_branch} --quiet
      echo -e "${RED}Reset to ${REMOTE}/${default_branch}${RESET}"
    fi
    
    echo
  done

  cd ../..
  #rm -rf devel/ build/
  echo -e "${WHITE}Deleted devel and build directories\n${RESET}"

  sleep 2
  #catkin_make
}; repo_reset
