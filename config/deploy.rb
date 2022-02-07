set :application, "Hilos"
set :user, "deploy"
set :repository,  "git@coto:repos/#{application}.git"

if ENV['production']
  set :domain, "sbc"
else
  set :domain, "coto"
end

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

#set :deploy_via, :remote_cache

role :app, domain
role :web, domain
role :db,  domain, :primary => true

set :rails_env, "production"
set :sphinx, "true"
#cat ~/.ssh/id_rsa.pub | ssh git@coto "cat >> .ssh/authorized_keys2"

after "deploy:cold", "ts_start"
after "deploy:symlink", "ts_index"
after "gem_install", "deploy:update_crontab"

task :copy_translations do
  system "scp -r #{user}@#{domain}:/var/www/apps/#{application}/current/config/locales ./config/locales/server/"
end