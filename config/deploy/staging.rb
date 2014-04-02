set :production_deploy_to, "/var/www/apps/#{application}"
set :deploy_to, "#{production_deploy_to}_prova"

desc "Clone production data"
task :clonedata, :roles => :app do
  run "mongo", :data => "db.copyDatabase('mint-prod', 'mintt-staging')"
  # run "/usr/bin/rsync -avh --delete  #{production_deploy_to}/shared/uploads/  #{shared_path}/uploads/"
end
