# My nerd blog


This blog will speak about technical stuff that I play
or try on my personal systems.

## Getting started

**One time task**

- Install dependencies:

  ```sh
  sudo dnf install -y toolbox direnv

  pushd ~
  mkdir opt
  cd opt
  git clone https://github.com/little-engineer-2025/toolbox-sh
  cd toolbox-sh
  ./toolbox.sh install
  popd
  ```

- Clone this repository: `git clone https://github.com/little-engineer-2025/blog.git`
- Create your `.envrc` file.

  ```sh
  echo 'export TOOLBOX="blog-dev"' >> .envrc
  direnv allow
  ```

- Install java: https://www.oracle.com/java/technologies/downloads/
- Install plantuml: https://plantuml.com/es/download
- Install graphviz: https://www.graphviz.org/download/
- (optional) install vscode pluging for plantuml: https://marketplace.visualstudio.com/items?itemName=jebbs.plantuml

- Create toolbox: `toolbox.sh create`

**On time task - alternative**

```sh
cd ~/workspace
toolbox create blog
toolbox enter blog
sudo dnf install make python3-pelican
git clone https://github.com/little-engineer-2025/blog.git
git submodule init
git submodule update
python3 -m venv .venv
source .venv/bin/activate
pip install -U pip
pip install -r requirements.txt
make devserver
# Go to http://127.0.0.1:8000
``

**Day to day**

- Enter in the toolbox and activate the virtual environment:

  ```sh
  toolbox.sh enter
  source .venv/bin/activate
  ```

- Keep server running ( listening at http://localhost:8000 )

  ```sh
  make serve
  ```

- Create a new branch for your new article: `git checkout -b my-article`
- Create a new article: `make new-article`
- Edit your new article at: `content/...` and refresh the content
  on your browser.
- When the article looks ready, change `Status: draft` to `Status: published`
- Commit regularly, and reorg your commits before push.
- When everything is done, create your pull request, and after review and merge
  your article is published.

## References

- Main cover photo from: https://c1.wallpaperflare.com/preview/811/367/789/technology-computer-creative-design.jpg
- Photo by form PxHere (Cover photo).
- Favicon generated from: https://favicon.io/

