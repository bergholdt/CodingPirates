#!/bin/sh
set -eu
if [ ! -f /workspace/.piratkode-klargjort ]; then
  cp -R /opt/kursus/undervisning /workspace/
  cp -R /opt/kursus/docs /workspace/
  cp -R /opt/kursus/illustrationer /workspace/
  cp /opt/kursus/kursus.html /workspace/
  touch /workspace/.piratkode-klargjort
fi
exec code-server --bind-addr 0.0.0.0:8080 --auth password --disable-telemetry /workspace
