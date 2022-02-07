set :application, "Hilos"
set :user, "deploy"
set :repository,  "nelsonde@nelsondewitt.com:repos/#{application}.git"

if ENV['staging']
  set :domain, "staging"
else
  set :domain, "sbc"
end

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

# set :local_scm_command, "/usr/local/bin/git"
# set :scm_command, "/usr/bin/git"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

set :rails_env, "production"

#cat ~/.ssh/id_rsa.pub | ssh nelsonde@nelsondewitt.com "cat >> .ssh/authorized_keys2"
namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  task :setup, :except => { :no_release => true } do
    dirs = [deploy_to, releases_path, shared_path]
    dirs += shared_children.map { |d| File.join(shared_path, d) }
    run "mkdir -p #{dirs.join(' ')} && chmod g+w #{dirs.join(' ')}"
  end
  
  task :cold do
    update
    create_db
    migrate
    start
  end
  
  task :create_db do
    rake = fetch(:rake, "rake")
    rails_env = fetch(:rails_env, "production")
    migrate_env = fetch(:migrate_env, "")
    migrate_target = fetch(:migrate_target, :latest)

    directory = case migrate_target.to_sym
      when :current then current_path
      when :latest  then current_release
      else raise ArgumentError, "unknown migration target #{migrate_target.inspect}"
      end

    run "cd #{directory}; #{rake} RAILS_ENV=#{rails_env} #{migrate_env} db:create"
  end
  
  before "deploy", "update_repo"
  before "deploy:cold", "update_repo"
  task :update_repo do
    system "git push nelson"
  end
  
end
