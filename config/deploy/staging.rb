# -*- encoding : utf-8 -*-
# module UseScpForDeployment
#   def self.included(base)
#     base.send(:alias_method, :old_upload, :upload)
#     base.send(:alias_method, :upload, :new_upload)
#   end

#   def new_upload(from, to)
#     old_upload(from, to, :via => :scp)
#   end
# end

# Capistrano::Configuration.send(:include, UseScpForDeployment)
role :web, "185.16.40.109"                          # Your HTTP server, Apache/etc
role :app, "185.16.40.109"                          # This may be the same as your `Web` server
role :db,  "185.16.40.109", :primary => true # This is where Rails migrations will run
role :db,  "185.16.40.109"

set :user, "user"
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:auth_methods] = ["publickey"]
ssh_options[:port] = 2200
ssh_options[:keys] = ["#{ENV['HOME']}/install/ruby/amazon/vps.pem"]

set :deploy_to, "/home/user/www/sites/muzkom"

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end

  task :bundle do
    run "cd #{release_path} && bundle install --gemfile #{release_path}/Gemfile"
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
