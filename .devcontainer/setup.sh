#!/bin/sh
set -eu
cd /workspace
for app in undervisning/04-flaskepost/start undervisning/04-flaskepost/facit undervisning/05-faelles-logbog/start undervisning/05-faelles-logbog/facit; do
  (cd "$app" && bundle check && ruby bin/rails db:prepare)
done
printf '\nKlar! Vælg Terminal → Run Task → Start app.\n'
