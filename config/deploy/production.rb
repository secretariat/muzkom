# -*- encoding : utf-8 -*-
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
role :web, "193.169.188.185"                          # Your HTTP server, Apache/etc
role :app, "193.169.188.185"                          # This may be the same as your `Web` server
role :db,  "193.169.188.185", :primary => true # This is where Rails migrations will run
role :db,  "193.169.188.185"

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
    run "cd #{release_path} && bundle exec rake RAILS_ENV=production RAILS_GROUPS=assets assets:precompile"
  end

  task :migrations do
    run "cd #{release_path} && bundle exec rake db:migrate RAILS_ENV=production"
  end

  task :refresh_sitemaps do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} rake sitemap:refresh"
  end
end
