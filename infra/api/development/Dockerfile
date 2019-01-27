FROM ruby:2.5.0

RUN apt-get update -qq && \
	apt-get install -y \
	build-essential \
	libpq-dev \
	postgresql-client

WORKDIR /usr/src/app

COPY ./api/Gemfile* ./

COPY ./scripts/after_db_ready.sh /usr/local/bin

RUN bundle install

VOLUME /usr/src/app

RUN chmod 755 /usr/local/bin/after_db_ready.sh

ENTRYPOINT ["/usr/local/bin/after_db_ready.sh"]

CMD ["rails", "s", "-b", "0.0.0.0"]
