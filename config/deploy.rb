require 'capistrano_colors'

def run_rake(*tasks)
  rails_env = fetch(:rails_env, "production")
  rake = fetch(:rake, "rake")
  tasks.each do |t|
    run "cd #{current_path} && source $HOME/.bash_profile && #{rake} RAILS_ENV=#{rails_env} #{t}"
  end
end

set :application, "muzkom"

default_run_options[:pty] = true
set :scm, :git
set :branch, 'master'
set :scm_verbose, true
set :repository,  "git@gitorious.org:muzkom/muzkom.git"
set :deploy_via, :copy
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

ssh_options[:port] = 7822
set :use_sudo, false
set :user, "chaplins"
set :copy_remote_dir, '/home/chaplins/tmp'
set :deploy_to, "/home/chaplins/public_html/#{application}"
set :keep_releases, 5

role :web, "a2s66.a2hosting.com"                          # Your HTTP server, Apache/etc
role :app, "a2s66.a2hosting.com"                          # This may be the same as your `Web` server
role :db,  "a2s66.a2hosting.com", :primary => true # This is where Rails migrations will run
role :db,  "a2s66.a2hosting.com"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  task :database do
    run "ln -fs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
    run "ln -fs #{shared_path}/config/.htaccess #{current_path}/public/.htaccess"
  end
  
  task :assets do
    run "mv #{current_path}/config/environments/production.rb #{current_path}/config/environments/_production.rb"
    run "ln -fs #{shared_path}/config/production.rb #{current_path}/config/environments/production.rb"
    run_rake "RAILS_GROUPS=assets assets:precompile"
    run "rm #{current_path}/config/environments/production.rb && mv #{current_path}/config/environments/_production.rb #{current_path}/config/environments/production.rb"
  end
  
  task :bundle do
    run "ln -fs #{shared_path}/uploads #{current_path}/public/uploads"
    run "source $HOME/.bash_profile && bundle install --gemfile #{current_path}/Gemfile"
  end
end
#after "deploy:bundle", "deploy:database"
after "deploy:update_code", "deploy:assets"
after "deploy:symlink", "deploy:bundle"
