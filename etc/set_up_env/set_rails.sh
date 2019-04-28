#!/bin/bash
# Script to download individual .nc files from the ORNL
# Daymet server at: http://daymet.ornl.gov

git clone https://github.com/HashNuke/asdf.git $HOME/.asdf
echo '. $HOME/.asdf/asdf.sh' >> $HOME/.bashrc

. $HOME/.bashrc

sudo apt-get install automake autoconf libpq-dev libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev dirmngr gpg nginx

$HOME/.asdf/bin/asdf plugin-add ruby https://github.com/HashNuke/asdf-ruby.git
$HOME/.asdf/bin/asdf plugin-add postgres https://github.com/smashedtoatoms/asdf-postgres.git
$HOME/.asdf/bin/asdf plugin-add sqlite https://github.com/cLupus/asdf-sqlite.git
$HOME/.asdf/bin/asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git

bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

$HOME/.asdf/bin/asdf install ruby 2.6.1
$HOME/.asdf/bin/asdf install postgres 9.4.10
$HOME/.asdf/bin/asdf install sqlite 3.27.2
$HOME/.asdf/bin/asdf install nodejs 11.1.0
echo 'ruby 2.6.1' >> ~/.tool-versions
echo 'postgres 9.4.10' >> ~/.tool-versions
$HOME/.asdf/bin/asdf global ruby 2.6.1
$HOME/.asdf/bin/asdf global postgres 9.4.10
$HOME/.asdf/bin/asdf global nodejs 11.1.0
$HOME/.asdf/bin/asdf global sqlite 3.27.2
