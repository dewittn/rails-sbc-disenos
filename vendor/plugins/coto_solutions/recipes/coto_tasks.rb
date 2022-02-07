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
    rake_setup
    run "cd #{@directory}; sudo #{@rake} RAILS_ENV=#{@rails_env} #{@migrate_env} db:schema:load"
  end
  
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && /opt/ruby-enterprise/bin/whenever --update-crontab #{application}"
  end
  
  def rake_setup
    @rake = fetch(:rake, "rake")
    @rails_env = fetch(:rails_env, "production")
    @migrate_env = fetch(:migrate_env, "")
    @migrate_target = fetch(:migrate_target, :latest)

    @directory = case @migrate_target.to_sym
      when :current then current_path
      when :latest  then current_release
      else raise ArgumentError, "unknown migration target #{@migrate_target.inspect}"
      end
  end
  
end

before "deploy", "update_repo"
before "deploy:cold", "update_repo"
before "deploy:migrations", "update_repo"
task :update_repo do
  system "git push coto"
end

after "deploy", "gem_install"
before "deploy:create_db", "gem_install"
after "deploy:migrations", "gem_install"
task :gem_install do
  rake_setup
  run "cd #{@directory}; sudo #{@rake} RAILS_ENV=#{@rails_env} #{@migrate_env} gems:install"
end

task :pro_log do
  stream "tail -f #{deploy_to}/current/log/production.log"
end

task :ts_index do
  rake_setup
  run "cd #{@directory}; sudo #{@rake} RAILS_ENV=#{@rails_env} #{@migrate_env} ts:in"
end

task :ts_stop do
  rake_setup
  run "cd #{@directory}; sudo #{@rake} RAILS_ENV=#{@rails_env} #{@migrate_env} ts:stop"
end

task :ts_start do
  rake_setup
  run "cd #{@directory}; sudo #{@rake} RAILS_ENV=#{@rails_env} #{@migrate_env} ts:start"
end

def rake_setup
  @rake = fetch(:rake, "rake")
  @rails_env = fetch(:rails_env, "production")
  @migrate_env = fetch(:migrate_env, "")
  @migrate_target = fetch(:migrate_target, :latest)

  @directory = case @migrate_target.to_sym
    when :current then current_path
    when :latest  then current_release
    else raise ArgumentError, "unknown migration target #{@migrate_target.inspect}"
    end
end
