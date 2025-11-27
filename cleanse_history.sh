#!/usr/bin/env bash
# Uses BFG to remove files or patterns from history.
# Install bfg: https://rtyley.github.io/bfg-repo-cleaner/
if [ -z "$1" ]; then
  echo "Usage: $0 <regex-or-filepath>"
  exit 1
fi
echo "Creating mirror..."
git clone --mirror . repo.git
bfg --delete-files "$1" repo.git
cd repo.git
git reflog expire --expire=now --all && git gc --prune=now --aggressive
echo "Push cleaned history to remote with: git push --force"
