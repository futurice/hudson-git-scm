#!/bin/sh

# This script pulls the specified branch (and optionally tag) into the
# current directory.

### Check Usage
if [ $# -lt 2 ]
then
    echo 'Usage: gitScm repository branch-name tag-name'
    exit 1
fi

### Init arguments
repo=$1
branch=$2
tag=$3

### Clone if needed
if [ ! -d ".git" ]
then
    git clone $repo .
fi

### Switch branch
git branch | sed s/'^..'// | grep -q "^$branch$"
if [ $? -eq 0 ]
then
    # local branch
    git checkout $branch
else
    # remote branch
    git checkout -b $branch origin/$branch
fi

### Pull
git pull

### Tag
# needs to be done after pull, otherwise we might not know of the
# required tag
if [ "$tag" != "" ]
then
    git checkout $tag
fi
    

