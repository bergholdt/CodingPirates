FROM ruby:4.0.8-slim
WORKDIR /rails
RUN apt-get update -qq && apt-get install --no-install-recommends -y build-essential libyaml-dev libsqlite3-dev sqlite3 ca-certificates && rm -rf /var/lib/apt/lists/*
COPY Gemfile Gemfile.lock ./
RUN bundle install && useradd --create-home --uid 1000 rails
COPY --chown=rails:rails . .
RUN mkdir -p storage log tmp/pids && chown -R rails:rails storage log tmp && chmod +x bin/*
USER rails
ENV RAILS_ENV=production
EXPOSE 3000
ENTRYPOINT ["./bin/docker-entrypoint"]
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
