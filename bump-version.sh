#!/bin/bash

#which wget > /dev/null 2>&1 || { echo "wget not installed, aborting"; exit 1 }

if [[ $# -lt 2 ]]; then
  echo "bump-version.sh
USAGE: ./bump-version.sh [ORG] REPO VERSION"
  exit 1
fi

ORG=${1:IdlePhysicist}
REPO=$2
VERSION=$3
for v in $REPO $VERSION; do
  if [[ -z $v ]]; then
    echo "$v not specified"
    exit 1
  fi
done


URL="https://github.com/$ORG/$REPO/archive/v$VERSION.tar.gz"
wget -q -O /tmp/v$VERSION.tar.gz $URL

if [[ $? -ne 0 ]]; then
  echo "wget error."; exit 1
fi

SHA=$(shasum -a 256 /tmp/v$VERSION.tar.gz | cut -d ' ' -f1)

OLD_V=$(grep 'version \"' ./$REPO.rb | head -n 1 | sed -e 's/\"/\\\"/g')
sed -ie "s/${OLD_V}/  version \"$VERSION\"/g" ./$REPO.rb

OLD_SHA=$(grep 'sha256' ./$REPO.rb | sed -e 's/\"/\\\"/g')
sed -ie "s/${OLD_SHA}/  sha256 \"${SHA}\"/g" ./$REPO.rb

