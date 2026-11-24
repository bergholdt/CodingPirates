FROM piratkode-dev:2026-11
USER root
COPY --chown=pirate:pirate . /kursus
USER pirate
WORKDIR /kursus
RUN sh tests/rails.sh
