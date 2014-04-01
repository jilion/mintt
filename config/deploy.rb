require 'bundler/capistrano'


#===============
# = Multistage =
#===============
# b cap staging deploy
# b cap production deploy
set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

#===========
# = CONFIG =
#===========

set :ssh_options, { :forward_agent => true }

set :application, "mintt.epfl.ch"
set :scm, :git
# set :repository, "https://github.com/jilion/mintt"
set :repository, "ssh://cangiani@lth.epfl.ch/repos/git/mintt.git"
set :branch, "master"
set :ssh_options, { :forward_agent => true }
# set :deploy_via, :remote_cache
set :stage, :production
set :user, "deploy"
set :use_sudo, false
set :runner, "deploy"
set :app_server, :passenger
set :domain, "srisrv1.epfl.ch"


#==========
# = ROLES =
#==========

role :app, domain
role :web, domain
role :db, domain, :primary => true

# ==================
# = Static Folders =
# ==================

before "deploy:create_symlink", "folders:symlink"

namespace :folders do
  task :symlink do
    run "ln -nsf #{shared_path}/media #{release_path}/public/media"
    run "ln -nsf #{shared_path}/uploads #{release_path}/public/uploads"
  end
end

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
  task :stop, :roles => :app do
  # Do nothing.
  end
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end

desc "Tail log files"
task :tail, :roles => :app do
  run "tail -n 500 -f #{shared_path}/log/#{rails_env}.log" do |channel, stream, data|
    puts "#{channel[:host]}: #{data}"
    break if stream == :err
  end
end
