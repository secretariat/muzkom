require 'capistrano_colors'

set :application, "muzkom"

set :scm, :git
set :scm_verbose, true
set :repository,  "git@gitorious.org:muzkom/muzkom.git"
set :branch, 'master'
set :deploy_via, :copy

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
default_run_options[:pty] = true
ssh_options[:port] = 7822
role :web, "a2s66.a2hosting.com"                          # Your HTTP server, Apache/etc
role :app, "a2s66.a2hosting.com"                          # This may be the same as your `Web` server
role :db,  "a2s66.a2hosting.com", :primary => true # This is where Rails migrations will run
role :db,  "a2s66.a2hosting.com"

set :use_sudo, false
set :user, "chaplins"
set :copy_remote_dir, '/home/chaplins/tmp'
set :deploy_to, "/home/chaplins/public_html/#{application}"
set :keep_releases, 5


namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/.htaccess #{release_path}/public/.htaccess"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end
  
  task :bundle do
    run "cd #{release_path} && source $HOME/.bash_profile &&  bundle install --gemfile #{release_path}/Gemfile"
  end
  
  task :assets do
    run "cd #{release_path} && source $HOME/.bash_profile && rake RAILS_ENV=production RAILS_GROUPS=assets assets:precompile"
  end
  
end

after "deploy:update_code", "deploy:symlink_shared"
after "deploy:symlink_shared", "deploy:bundle"
after "deploy:bundle", "deploy:assets"