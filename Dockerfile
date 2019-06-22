FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev sqlite3 nodejs
RUN mkdir /facturacion
WORKDIR /facturacion
COPY Gemfile /facturacion/Gemfile
COPY Gemfile.lock /facturacion/Gemfile.lock
RUN gem update
RUN bundle install
# RUN sudo apt-get install libmysqlclient-dev
# RUN bundle exec rake db:migrate
COPY . /facturacion