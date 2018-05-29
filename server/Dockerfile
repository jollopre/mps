FROM ruby:2.5.0

RUN apt-get update -qq && \
	apt-get install -y \
	build-essential \
	libpq-dev \
	postgresql-client

WORKDIR /usr/src/app

COPY ./Gemfile* ./

RUN bundle install

VOLUME /usr/src/app

CMD ["rails", "s", "-b", "0.0.0.0"]


