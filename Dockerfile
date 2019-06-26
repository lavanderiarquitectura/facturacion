FROM ruby:2.5.1
RUN apt-get update -qq 
# && apt-get install -y build-essential libpq-dev sqlite3 nodejs
RUN mkdir /facturacion
WORKDIR /facturacion
COPY Gemfile /facturacion/Gemfile
COPY Gemfile.lock /facturacion/Gemfile.lock
# RUN gem update
RUN bundle install
# RUN apt-get install libmysqlclient-dev
# RUN bundle exec rake db:migrate
COPY . /facturacion

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]