#!/bin/bash

set -xe

rm -rf plugins
mkdir plugins
cd plugins
git clone https://github.com/robertmeta/plug.kak.git

echo Remember to install the kak-lsp binary package
