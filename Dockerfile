FROM ubuntu:16.04

MAINTAINER Jose Lloret <jollopre@gmail.com>

ENV RUBY_MAJOR 2.3
ENV RUBY_VERSION 2.3.3
ENV RUBY_DOWNLOAD_SHA256 241408c8c555b258846368830a06146e4849a1d58dcaf6b14a3b6a73058115b7
ENV RUBYGEMS_VERSION 2.6.8
ENV BUNDLER_VERSION 1.13

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		bzip2 \
		ca-certificates \
		libffi-dev \
		libgdbm3 \
		libssl-dev \
		libyaml-dev \
		procps \
		zlib1g-dev \
		tzdata \
	&& rm -rf /var/lib/apt/lists/*
# tzdata as per issue https://github.com/docker-library/official-images/issues/2863

ENV BUILD_DEPS '\
		bison \
		gcc \
		libbz2-dev \
		libgdbm-dev \
		libglib2.0-dev \
		libncurses-dev \
		libreadline-dev \
		libxml2-dev \
		libxslt-dev \
		ruby \
		wget'

RUN apt-get update \
	&& apt-get install -y --no-install-recommends ${BUILD_DEPS} \
	&& rm -rf /var/lib/apt/lists/* \
	&& wget -O ruby.tar.gz "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR}/ruby-${RUBY_VERSION}.tar.gz" \
	&& echo "$RUBY_DOWNLOAD_SHA256 *ruby.tar.gz" | sha256sum -c - \
	&& mkdir -p /usr/src/ruby \
	&& tar -xzf ruby.tar.gz -C /usr/src/ruby --strip-components=1 \
	&& rm ruby.tar.gz \
	&& cd /usr/src/ruby \
	&& ./configure --disable-install-doc --enable-shared \
	&& make -j"$(nproc)" \
	&& make install \
	&& cd / \
	&& rm -r /usr/src/ruby \
	&& gem update --system "$RUBYGEMS_VERSION"

RUN gem install bundler --version "$BUNDLER_VERSION"

# Environment variables for bundle
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME" \
	BUNDLE_BIN="$GEM_HOME/bin" \
	BUNDLE_SILENCE_ROOT_WARNING=1 \
	BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $BUNDLE_BIN:$PATH
RUN mkdir -p "$GEM_HOME" "$BUNDLE_BIN" \
	&& chmod 744 "$GEM_HOME" "$BUNDLE_BIN"

# Install Rails and its dependencies
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	nodejs \
	libpq-dev \
	postgresql-client \
	&& rm -rf /var/lib/apt/lists/*
WORKDIR /usr/src/app
COPY server/Gemfile* ./
RUN bundle install \
    && apt-get purge -y --auto-remove ${BUILD_DEPS}
VOLUME /usr/src/app

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]