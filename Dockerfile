# syntax=docker/dockerfile:1.7
ARG RUBY_VERSION=3.3.4
FROM ruby:${RUBY_VERSION}-slim AS base

RUN apt-get update -qq \
 && apt-get install -y --no-install-recommends build-essential ca-certificates curl git gnupg libpq-dev pkg-config tzdata \
 && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
 && apt-get install -y --no-install-recommends nodejs \
 && npm install -g npm@latest \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle \
    PATH=/bundle/bin:$PATH

FROM base AS prod_deps

COPY Gemfile Gemfile.lock ./
RUN bundle config set without 'development test' \
 && bundle install

COPY package.json package-lock.json ./
RUN npm ci

FROM prod_deps AS build

COPY . .
RUN npm run build \
 && rm -rf node_modules tmp log

FROM base AS development

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY package.json package-lock.json ./
RUN npm install

COPY . .

ENV RACK_ENV=development \
    NODE_ENV=development \
    PORT=3000

EXPOSE 3000

CMD ["./bin/dev"]

ARG APP_NAME=sinatra_template
ARG APP_TITLE="Sinatra Template"

FROM ruby:${RUBY_VERSION}-slim AS production

RUN apt-get update -qq \
 && apt-get install -y --no-install-recommends libpq-dev \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle \
    PATH=/bundle/bin:$PATH \
    RACK_ENV=production \
    NODE_ENV=production \
    PORT=8080 \
    APP_NAME=${APP_NAME} \
    APP_TITLE=${APP_TITLE}

COPY --from=build /bundle /bundle
COPY --from=build /app /app

EXPOSE 8080

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "--port", "8080"]

