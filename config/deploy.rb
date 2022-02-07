set :application, "inventario"
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

#cat ~/.ssh/id_rsa.pub | ssh git@coto "cat >> .ssh/authorized_keys2"
after "deploy:cold", "ts_index"
after "deploy:cold", "ts_start"
after "deploy", "ts_index"
after "deploy:migrations", "ts_index"