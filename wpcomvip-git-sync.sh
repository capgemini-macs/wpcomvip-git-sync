#!/bin/sh

set -e

SOURCE_REPO=$1
DESTINATION_REPO=$2

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

echo "SOURCE=$SOURCE_REPO:$SOURCE_BRANCH"
echo "DESTINATION=$DESTINATION_REPO:$DESTINATION_BRANCH"

git clone "$SOURCE_REPO" --origin source && cd `basename "$SOURCE_REPO" .git`
git remote add destination "$DESTINATION_REPO"

if ! echo $SOURCE_REPO | grep 'wpcomvip'
then
  git push destination "refs/remotes/source/review-master/*:refs/heads/review-master/*" -f
  git push destination "refs/remotes/source/review-preprod/*:refs/heads/review-preprod/*" -f
  git push destination "refs/remotes/source/review-develop/*:refs/headsreview-develop/*" -f
else
  git push destination "refs/remotes/source/master:refs/heads/master" -f
  git push destination "refs/remotes/source/preprod:refs/heads/preprod" -f
  git push destination "refs/remotes/source/develop:refs/heads/develop" -f
fi
