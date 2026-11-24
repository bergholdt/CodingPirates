FROM ghcr.io/coder/code-server:4.146.0 AS editor
FROM ruby:4.0.8-slim
RUN apt-get update -qq && apt-get install --no-install-recommends -y build-essential libyaml-dev libsqlite3-dev sqlite3 git curl ca-certificates procps && rm -rf /var/lib/apt/lists/*
COPY --from=editor /usr/lib/code-server /usr/lib/code-server
RUN ln -s /usr/lib/code-server/bin/code-server /usr/local/bin/code-server
WORKDIR /opt/gems
COPY undervisning/05-faelles-logbog/facit/Gemfile undervisning/05-faelles-logbog/facit/Gemfile.lock ./
RUN bundle install
RUN useradd --create-home --uid 1000 pirate && mkdir -p /workspace && chown pirate:pirate /workspace
COPY --chown=pirate:pirate undervisning /opt/kursus/undervisning
COPY --chown=pirate:pirate docs /opt/kursus/docs
COPY --chown=pirate:pirate illustrationer /opt/kursus/illustrationer
COPY --chown=pirate:pirate kursus.html /opt/kursus/kursus.html
COPY drift/start-editor.sh /usr/local/bin/start-editor
RUN chmod +x /usr/local/bin/start-editor
USER pirate
WORKDIR /workspace
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/start-editor"]
