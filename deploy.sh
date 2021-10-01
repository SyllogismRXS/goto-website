#!/bin/bash

gh_pages_branch="gh-pages"

# Get the directory containing this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
STATIC_PAGES_DIR="${DIR}/_site"

# Make sure the static pages directory is updated:
echo -e "\033[0;32mPulling origin/${gh_pages_branch} into _site\033[0m"
pushd ${STATIC_PAGES_DIR} >& /dev/null
  git pull origin ${gh_pages_branch}
popd > /dev/null

# change to the directory that contains this script
echo -e "\033[0;32mBuilding static pages...\033[0m"
pushd ${DIR} >& /dev/null
  # Build the jekyll site and copy to static pages directory
  JEKYLL_ENV=production bundle exec jekyll build
popd >& /dev/null

# Commit the static code and push it
echo -e "\033[0;32mDeploying to ${gh_pages_branch} branch...\033[0m"
pushd ${STATIC_PAGES_DIR} >& /dev/null
  git add --all
  git commit -m "Deploy static updates"
  git push origin ${gh_pages_branch}
popd >& /dev/null
