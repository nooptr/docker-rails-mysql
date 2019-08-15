FROM ruby:2.6.3
ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install -y nodejs \
                       vim \
                       mariadb-client \
                       --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Cache bundle install
WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bundle install

ENV APP_ROOT /workspace
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
COPY . $APP_ROOT

EXPOSE  3000
CMD rm -f tmp/pids/server.pid && rails s -b '0.0.0.0'
