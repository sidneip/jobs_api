FROM ruby:2.2

RUN apt-get update -qq && apt-get install -y build-essential sqlite3 libsqlite3-dev vim

ENV APP_HOME /app
ENV ENV_APP development_docker
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install --without development test

ADD . $APP_HOME/

RUN mkdir /db
RUN /usr/bin/sqlite3 /db/test.db
ENV LANG C.UTF-8
