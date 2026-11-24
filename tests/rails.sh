#!/bin/sh
set -eu
# Køres i Dev Containeren eller testimaget fra repoets rod.
cd "$(dirname "$0")/.."
root="$PWD"
for app in undervisning/04-flaskepost/start undervisning/04-flaskepost/facit undervisning/05-faelles-logbog/start undervisning/05-faelles-logbog/facit; do
  APP_DIR="$root/$app" ruby tests/rails_test.rb
done
