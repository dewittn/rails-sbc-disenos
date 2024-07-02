FROM wolfsoftwareltd/rbenv-debian:12 as build

RUN apt-get update -yqq && apt-get install -yqq build-essential zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev libdb-dev && apt-get -q clean 

#autoconf patch #rustc libreadline6-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev uuid-dev 

COPY .gemrc /root/.gemrc

RUN rbenv install 1.9.3-p286 && rbenv global 1.9.3-p286 && rbenv rehash

WORKDIR app/

COPY . .

RUN gem install bundler -v 1.15.4 --no-rdoc && rbenv rehash && bundle install

# FROM wolfsoftwareltd/rbenv-debian:12
# 
# RUN apt-get update -yqq && apt-get install -yqq build-essential zlib1g-dev libyaml-dev nodejs && apt-get -q clean 
# 
# RUN rbenv install 1.9.3-p286 && rbenv global 1.9.3-p286 && gem install bundler -v 1.15.4 --no-rdoc && rbenv rehash
# 
# COPY --from=build /root/app /root/app
# 
# WORKDIR app/

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server"]