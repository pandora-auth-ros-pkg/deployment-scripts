#!/bin/bash

# Include files
source /etc/bash_completion.d/git
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"

# Store command line arguments
DIRS=$(find $1 -maxdepth 1 -mindepth 1 -type d -not -name .git)
DEFAULT_BRANCH[0]=$2
DEFAULT_BRANCH[1]=$3

HEADER1="Repository"
HEADER2="Branch"
HEADER3="Status"

# Bold color list
colors ()
{
  RESET='\e[0m'
  BLACK='\e[1;30m'
  BOIBLACK='\e[1;100m'
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

# Stores the max string length of repos in $max
max_path_length ()
{
  MAX_P=${#HEADER1}
  
  local repo
  for repo in $DIRS; do
    local repo_short=`echo $repo | rev | cut -d "/" -f1-1 | rev`
    local repo_length=$((${#repo_short}+2))
    if (( "${repo_length}" > "${MAX_P}" )); then
      MAX_P=$repo_length
    fi 
  done
}

# Stores the max string length of branches in $max
max_branch_length ()
{
  MAX_B=${#HEADER2}
  
  local repo
  for repo in $DIRS; do
    cd ${repo// /\ }
    
    local git_exists=`ls -a | grep .git`
    if [ -z "${git_exists}" ]; then
      continue
    fi
    
    local curr_branch=`git rev-parse --abbrev-ref HEAD`
    local branch_length=${#curr_branch}
    if (( "${branch_length}" > "${MAX_B}" )); then
      MAX_B=$branch_length
    fi 
  done
}

# Main function
repostatus ()
{
  max_path_length
  max_branch_length
  
  local n

  # Add header
  local header1_length=${#HEADER1}
  local header2_length=${#HEADER2}
  echo -en "${BOIBLACK}${HEADER1}${RESET}"
  for ((n=0; n<=((MAX_P-header1_length+2)); n++)); do
    echo -n " "
  done
  echo -en "${BOIBLACK}${HEADER2}${RESET}"
  for ((n=0; n<=((MAX_B-header2_length+2)); n++)); do
    echo -n " "
  done
  echo -e "${BOIBLACK}${HEADER3}${RESET}"
  
  local repo
  for repo in $DIRS; do
    cd ${repo// /\ }
    
    # Shorten repo directory path
    local repo_short=`echo $repo | rev | cut -d "/" -f1-1 | rev`
    local repo_length=${#repo_short}
    echo -en "${BLUE}[${repo_short}]${RESET}"

    # Adjust spaces
    for ((n=0; n<=((MAX_P-repo_length)); n++)); do
      echo -n " "
    done
    
    local git_exists=`ls -a | grep .git`
    if [ -z "${git_exists}" ]; then
      echo -e "${YELLOW}Not a git repository!${RESET}"
      continue
    fi
    
    local curr_branch=`git rev-parse --abbrev-ref HEAD`
    local branch_length=${#curr_branch}
    local branch_length_total=$((${#curr_branch} + 2))

    # Get upstream and dirty state from git_ps1
    local git_ps1=$(__git_ps1)
    git_ps1=${git_ps1:${branch_length_total}}
    git_ps1=`echo $git_ps1 | xargs`
    git_ps1=${git_ps1::${#git_ps1}-1}
    git_ps1=`echo $git_ps1 | rev`
    
    echo -en "${RED}" # Branch not equal
    
    # Check if the current branch is equal to any of the default branches
    local branch
    for branch in ${DEFAULT_BRANCH[*]}; do    
      if [ $curr_branch == $branch ]; then
        echo -en "${GREEN}" # Branch equal
        break
      fi
    done
    
    echo -en "${curr_branch}${RESET}"
    
    # Adjust spaces
    for ((n=0; n<=((MAX_B-branch_length+4)); n++)); do
      echo -n " "
    done
    
    echo -e "${YELLOW}${git_ps1}${RESET}"
  done
}; repostatus
