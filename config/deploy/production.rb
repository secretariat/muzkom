module UseScpForDeployment
  def self.included(base)
    base.send(:alias_method, :old_upload, :upload)
    base.send(:alias_method, :upload, :new_upload)
  end
  
  def new_upload(from, to)
    old_upload(from, to, :via => :scp)
  end
end

Capistrano::Configuration.send(:include, UseScpForDeployment)
role :web, "194.28.84.147"                          # Your HTTP server, Apache/etc
role :app, "194.28.84.147"                          # This may be the same as your `Web` server
role :db,  "194.28.84.147", :primary => true # This is where Rails migrations will run
role :db,  "194.28.84.147"

set :user, "muzkomco"
set :copy_remote_dir, '/home/muzkomco/tmp'
set :deploy_to, "/home/muzkomco/public_html"

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end
  
  task :bundle do
    run "cd #{release_path} && bundle install --gemfile #{release_path}/Gemfile --path /home/muzkomco"
  end
  
  task :assets do
    run "cd #{release_path} && rake RAILS_ENV=production RAILS_GROUPS=assets assets:precompile"
  end
  
  task :migrations do
    run "cd #{release_path} && rake RAILS_ENV=production db:migrate"
  end
  
end