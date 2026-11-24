FROM piratkode-workshop:2026-11
USER root
COPY --chown=pirate:pirate . /kursus
USER pirate
WORKDIR /kursus
RUN sh tests/rails.sh
