# EN4PRO http://en4pr.com/

  Install `asdf`:

  ```bash
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.3.0
  ```

  Add the following lines to your `.bashrc`/`.bash_profile`/`.zshrc`, etc., as applicable:

  ```bash
  source $HOME/.asdf/asdf.sh
  source $HOME/.asdf/completions/asdf.bash
  ```

  Install the relevant utils required for your system:

  ```bash
  # OSX
  brew install coreutils automake autoconf openssl libyaml readline libxslt libtool unixodbc gnupg gnupg2

  # Ubuntu
  apt-get install automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev

  # Fedora/Red Hat
  yum install automake autoconf readline-devel ncurses-devel openssl-devel libyaml-devel libxslt-devel libffi-devel libtool unixODBC-devel
  ```

  Install the `asdf` plugins necessary for `ruby 2.6.1`, `postgres 9.4.10`, `sqlite 3.27.2` and `nodejs 11.1.0`:

  ```bash
  asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby
  asdf plugin-add postgres https://github.com/smashedtoatoms/asdf-postgres
  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
  asdf plugin-add sqlite https://github.com/cLupus/asdf-sqlite
  ```

  Install the versions in the `.tool-versions` file of the present directory:

  ```bash
  asdf install
  ```
  Update your hosts file so that you can use the host-based routing:

  ```
  # /etc/hosts

  127.0.0.1       en4pr.local
  ```
  

 1. Install js dependencies (optional)

    - `brew install --upgrade nodejs`
    - `npm install bower`
    - `bower install --save` (maybe `/usr/local/lib/node_modules/bower/bin/bower install --save`)

  2. Install dependencies

    - `gem install rails`
    - `gem install bundler`
    - `bundle install`

  3. Create and migrate your database 

    - `rails db:migrate`
    - `rails db:seed`

  4. Start Rails server with `rails server`

Now you can visit [`localhost:3000`](http://localhost:3000) from your browser.


## For Developer and Tester


Board team: https://eng4all.leankit.com/board/823861460.
Board team: https://trello.com/b/RGwAAYVj 

# Task Process

  1. Please create and assign task in Board: https://eng4all.leankit.com/board/823861460.
  2. Do task by moving task to column DOING NOW.
  3. Create a new branch for each task, all branch  depend on master branch.
  4. After test done in local, push that branch to github for reviewing.
  5. Comment the pushed branch and commited on task board and assign it to tester.
  6. Move task to lane "Ready for Review"

Ready to run in production?

# Test Process

  1. Pick task from lane "Ready for review"
  2. Connect to VM of server, test on it.
  3. Create a new branch for each task with format: `test-<<content of task>>`, all branch  depend on master branch.  
  4. Everything is ok, merge that branch to master. 
  
  If not, comment the errors on task and back assign to developer (Move task to lane Approved) or Create new bug in board and assign to developer.


### All commands for migration database
```
rails db:drop
rails db:create
rails db:migrate
rails db:seed
```

### All commands for local
```
bundle install
rails server
```
