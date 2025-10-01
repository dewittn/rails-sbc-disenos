FROM wolfsoftwareltd/rbenv-debian:11

RUN apt-get update -yqq \
    && apt-get install -yqq build-essential zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev libdb-dev nodejs \
    && apt-get -q clean \
    && rbenv install 1.9.3-p286 && rbenv global 1.9.3-p286 && gem install bundler -v 1.15.4 --no-rdoc \
    && rbenv rehash

WORKDIR app/

ADD . .

RUN bundle install --verbose

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server"]