#===========
# = CONFIG =
#===========

set :application, "mintt.epfl.ch"
set :scm, :git
set :repository, "git@jime1.epfl.ch:mintt.git"
set :branch, "master"
set :ssh_options, { :forward_agent => true }
# set :deploy_via, :remote_cache
set :stage, :production
set :user, "deploy"
set :use_sudo, false
set :runner, "deploy"
set :deploy_to, "/var/www/apps/#{application}"
set :app_server, :passenger
set :domain, "srisrv1.epfl.ch"

#==========
# = ROLES =
#==========

role :app, domain
role :web, domain
role :db, domain, :primary => true

# ======
# = DB =
# ======

# after "deploy:symlink", "db:symlink"
# before "deploy:symlink", "asset:prepare"
# after "asset:prepare", "asset:copyright"
# after "asset:copyright", "asset:upload"
# 
# namespace :asset do
#   task :prepare do
#     run "cd #{release_path}; jammit -u http://jilion.com"
#   end
#   
#   task :copyright do
#     run "cd #{release_path}; rake copyright:add_to_top RAILS_ENV=production"
#   end
#   
#   task :upload do
#     run "cd #{release_path}; rake cdn:assets:upload RAILS_ENV=production"
#   end
# end
# 
# namespace :db do
#   task :symlink do
#     run "ln -nsf #{shared_path}/medias #{release_path}/public/medias"
#     run "ln -nsf #{shared_path}/uploads #{release_path}/public/uploads"
#     run "ln -nsf #{shared_path}/test #{release_path}/public/test"
#   end
# end

# ==================
# = Static Folders =
# ==================

before "deploy:symlink", "folders:symlink"

after "deploy:update_code" do
  bundler.bundle_new_release
end

namespace :folders do
  task :symlink do
    run "ln -nsf #{shared_path}/media #{release_path}/public/media"
    run "ln -nsf #{shared_path}/uploads #{release_path}/public/uploads"
  end
end

namespace :bundler do
  desc "Create symlink for bundler"
  task :create_symlink, :roles => :app do
    shared_dir  = File.join(shared_path, 'bundle')
    release_dir = File.join(current_release, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end
  
  desc "Bundle new release (bundle install)"
  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} && bundle install #{release_path}/.bundle --without test"
  end
  
  desc "Bundle lock"
  task :lock, :roles => :app do
    run "cd #{current_release} && bundle lock"
  end
  
  desc "Bundle unlock"
  task :unlock, :roles => :app do
    run "cd #{current_release} && bundle unlock"
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