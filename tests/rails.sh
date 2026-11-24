#!/bin/sh
set -eu
# Køres i det byggede workshop-image med repoet monteret som /kursus.
cd /kursus
for app in undervisning/04-flaskepost/start undervisning/04-flaskepost/facit undervisning/05-faelles-logbog/start undervisning/05-faelles-logbog/facit; do
  APP_DIR="/kursus/$app" ruby tests/rails_test.rb
done
