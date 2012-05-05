require "bundler/capistrano"

server "106.187.54.84", :web, :app, :db, primary: true

set :application, "tedx"
set :user, "deploy"

set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:ballantyne/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

task :production do
  set :env, 'production'
  set :deploy_to, "/home/#{user}/apps/#{application}/#{env}"
  set :branch, 'production'
  set :compile_assets_locally, true
  # set :unicorn_binary, "/home/scott/.rvm/gems/ruby-1.9.2-p290@transist/bin/unicorn"
  # set :unicorn_config, "/var/www/transist/current/config/unicorn.rb"
  # set :unicorn_pid, "/var/www/transist/current/tmp/pids/unicorn.pid"
  # set :java_home, "/usr/lib/jvm/java-6-openjdk"
end

task :beta do
  set :env, 'staging'
  set :rails_env, 'staging'
  set :deploy_to, "/home/#{user}/apps/#{application}/#{env}"
  set :branch, 'beta'
  set :compile_assets_locally, false
  # set :current_port, 9090
  # set :unicorn_binary, "/home/scott/.rvm/gems/ruby-1.9.2-p290@transist/bin/unicorn"
  # set :unicorn_config, "/var/www/beta.transi.st/current/config/unicorn.rb"
  # set :unicorn_pid, "/var/www/beta.transi.st/current/tmp/pids/unicorn.pid"
  # set :java_home, "/usr/lib/jvm/java-6-openjdk"
end


namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application}_#{env} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx_#{env}.conf /etc/nginx/sites-enabled/#{application}_#{env}"
    sudo "ln -nfs #{current_path}/config/unicorn_init_#{env}.sh /etc/init.d/unicorn_#{application}_#{env}"
    run "mkdir -p #{shared_path}/config"
    # put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -s #{shared_path}/tmp/cache #{release_path}/tmp/cache"
    run "cd #{release_path} && RAILS_ENV=#{env} bundle exec rake i18n:js:setup  --trace"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      # exit
    end
  end
  before "deploy", "deploy:check_revision"
end