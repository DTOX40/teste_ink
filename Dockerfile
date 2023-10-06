FROM ruby:3.2.2-alpine3.18

RUN apk add --update build-base bash bash-completion libffi-dev tzdata postgresql-client postgresql-dev

WORKDIR /app

COPY Gemfile* /app/

RUN gem install bundler -v 2.4.19

RUN bundle install

RUN bundle binstubs --all

CMD [ "/bin/bash" ]