#!/bin/sh

# exit if any errors occur
set -e;

# change to source code directory
cd "$GITHUB_WORKSPACE";

CONFIG_FILE="${configFile:-/uncrustify-default.cfg}"
FILE_SELECTOR="$(echo '*.cs' '*.c' '*.cpp' '*.h' '*.hpp' '*.m' '*.mm' '*.M')"

DEFAULT_BRANCH="$(git remote show origin | grep 'HEAD branch' | awk '{ print $3 }')"
#CURRENT_BRANCH="${GITHUB_HEAD_REF#refs/heads/}"
CURRENT_BRANCH="remotes/pull/2/merge"
FILES_CHANGED="$(git diff --name-status --diff-filter=AM origin/${DEFAULT_BRANCH}...${CURRENT_BRANCH} -- $FILE_SELECTOR | awk '{ print $2 }')"

# exit if check doesn't pass
set -e;

# run checks on changed files
for FILE in $FILES_CHANGED; do
    uncrustify -c "${CONFIG_FILE}" --check "${FILE}";
done;

echo "CONFIG PATH: $CONFIG_FILE";
echo "CURRENT BRANCH: $CURRENT_BRANCH";
echo "DEFAULT BRANCH: $DEFAULT_BRANCH";
echo "FILE SELECTOR: $FILE_SELECTOR";
echo "FILE CHANGED: $FILES_CHANGED";
git branch -a;

exit 0;
