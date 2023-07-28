#!/bin/sh

set -e

if [ "$SOURCE_REPO" == "$TRIGGERED_BY" ]; then
  echo "Ignoring triggered by $TRIGGERED_BY. Exiting..."
  exit 0

if ! echo $SOURCE_REPO | grep '.git'
then
  if [[ -n "$SSH_PRIVATE_KEY" ]]
  then
    SOURCE_REPO="git@github.com:${SOURCE_REPO}.git"
    GIT_SSH_COMMAND="ssh -v"
  else
    SOURCE_REPO="https://github.com/${SOURCE_REPO}.git"
  fi
fi
if ! echo $DESTINATION_REPO | grep '.git'
then
  if [[ -n "$SSH_PRIVATE_KEY" ]]
  then
    DESTINATION_REPO="git@github.com:${DESTINATION_REPO}.git"
    GIT_SSH_COMMAND="ssh -v"
  else
    DESTINATION_REPO="https://github.com/${DESTINATION_REPO}.git"
  fi
fi

echo "Cloning source repo: $SOURCE_REPO..."
git clone "$SOURCE_REPO" --origin source

SOURCE_DIR=`basename "$SOURCE_REPO" | sed s/".git"//`
echo "Change DIR to $SOURCE_DIR..."
cd $SOURCE_DIR

echo "Add destination remote $DESTINATION_REPO..."
git remote add destination "$DESTINATION_REPO"

if ! echo $SOURCE_REPO | grep 'wpcomvip'
then
  echo "Pushing to "$DESTINATION_REPO" branch "$BRANCH"..."
  git push destination "refs/remotes/source/$BRANCH:refs/heads/$BRANCH" -f -v
fi

