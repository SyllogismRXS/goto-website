# goto;s website

## One Time Setup

### Git Project

reference: http://sangsoonam.github.io/2019/02/08/using-git-worktree-to-deploy-github-pages.html

Create gh-pages branch that is orphaned

    $ git checkout --orphan gh-pages
    $ git reset --hard
    $ git commit --allow-empty -m "Init"
    $ git checkout master

Setup _site as a git worktree of the gh-pages branch

    $ rm -rf _site
    $ git worktree add _site gh-pages

### DNS Servers

ref: https://deanattali.com/blog/multiple-github-pages-domains/

Initially messed up Step 4: adding dot (.) to end of syllogismrxs.github.io.

### Development system setup

Install git-lfs, which is used for images and large binary files:

    $ sudo apt-get install git-lfs

Install the git-lfs hooks for this repo:

    $ cd /path/to/this/repo
    $ git lfs install

Pull down the git-lfs objects:

    $ git lfs pull

Install ruby:

    $ sudo apt install ruby-full

Setup path and gems location:

    $ echo 'export GEM_HOME="${HOME}/gems"' >> ~/.bashrc && \
      echo 'export PATH="${GEM_HOME}/bin:${PATH}"' >> ~/.bashrc

Install bundler and jekyll

    $ gem install bundler
    $ gem install jekyll


## Development

Install packages for this blog

    $ bundle install

Start the web server to view the website

    $ bundle exec jekyll serve

## Deploy

The static pages need to be pushed to the "gh-pages" branch to be served by
GitHub. I use a separate git worktree to make this process easier.

Build the production code.

    $ JEKYLL_ENV=production bundle exec jekyll build

The production website is built to `_site` and since that's a git worktree, we
just have to create a commit and push it.

    $ cd _site
    $ git add --all
    $ git commit -m "Deploy updates"
    $ git push origin gh-pages

Alternatively, you can use the `deploy.sh` to perform the build, commit, and
push steps, assuming the git worktree has been setup already.
