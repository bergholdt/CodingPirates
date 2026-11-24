FROM ruby:4.0.8-slim
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    build-essential libyaml-dev libsqlite3-dev sqlite3 git curl ca-certificates procps \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /opt/gems
COPY undervisning/05-faelles-logbog/facit/Gemfile undervisning/05-faelles-logbog/facit/Gemfile.lock ./
RUN bundle install
RUN useradd --create-home --uid 1000 pirate
USER pirate
WORKDIR /workspace
CMD ["sleep", "infinity"]
