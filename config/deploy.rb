    # -*- encoding : utf-8 -*-
# require 'capistrano_colors'
require 'capistrano/ext/multistage'
require "bundler/capistrano"

default_run_options[:pty] = true

set :application, "muzkom"

set :default_shell, '/bin/bash -l'

set :scm, :git
set :scm_verbose, true
# set :repository,  "git@gitorious.org:muzkom/muzkom.git"
set :repository,  "git@github.com:secretariat/muzkom.git"
#set :branch, 'master'
set :branch, 'develop'
set :deploy_via, :copy

set :use_sudo, false
set :keep_releases, 5

set :stages, ["staging", "production"]
set :default_stage, "staging"

after "deploy:update_code", "deploy:symlink_shared"
after "deploy:symlink_shared", "deploy:bundle"
after "deploy:bundle", "deploy:assets"
# after "deploy:assets", "deploy:migrations"
after "deploy:create_symlink", "deploy:cleanup"
# after "deploy:cleanup", "deploy:refresh_sitemaps"
